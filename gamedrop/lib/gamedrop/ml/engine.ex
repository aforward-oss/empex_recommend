defmodule Gamedrop.Ml.Engine do
  use GenServer
  alias Gamedrop.Repo

  @all_budgets [1, 2, 3]

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    :timer.send_after(10_000, self(), :train)
    {:ok, {nil, nil, nil}}
  end

  def predict(budget, game_types) do
    {:ok, answer} = GenServer.call(__MODULE__, {:predict, budget, game_types})
    answer
  end

  def train(), do: GenServer.cast(__MODULE__, :train)

  def handle_call({:predict, budget, game_types}, _from, state) do
    result = do_prediction(budget, game_types, state)
    {:reply, result, state}
  end

  def handle_cast(:train, _state) do
    {:noreply, do_train()}
  end

  def handle_info(:train, _state) do
    {:noreply, do_train()}
  end

  defp do_prediction(_, _, {nil, _, _}), do: nil

  defp do_prediction(budget, game_types, {model, all_game_types, all_game_names}) do
    x =
      Nx.concatenate({
        Tx.one_hot_encode(budget, @all_budgets),
        Tx.multi_hot_encode(game_types, all_game_types)
      })
      |> Nx.to_list()
      |> then(&Nx.tensor([&1]))

    apply(model.__struct__, :predict, [model, x])
    |> Nx.to_list()
    |> List.first()
    |> then(&Enum.fetch(all_game_names, &1))
  end

  def do_train() do
    IO.puts("Training the data set")

    all_game_types = gameplay_types()
    all_game_names = game_names()
    num_categories = Enum.count(all_game_names) |> IO.inspect()

    {x, y} =
      Repo.run_sql("""
      SELECT CASE
                 WHEN rental_cost < 5 THEN 1
                 WHEN rental_cost < 20 THEN 2
                 ELSE 3
             END AS budget,
             gameplay_types,
             game_name
      FROM gameplays
      WHERE top_rated = true
      ORDER BY console_name, game_name
      """)
      |> then(& &1.rows)
      |> Enum.map(fn [budget, game_types, game_name] ->
        {Nx.concatenate({
           Tx.one_hot_encode(budget, @all_budgets),
           Tx.multi_hot_encode(game_types, all_game_types)
         })
         |> Nx.to_list(), Tx.category_encode(game_name, all_game_names) |> Nx.to_number()}
      end)
      |> Enum.reduce({[], []}, fn {features, labels}, {all_features, all_labels} ->
        {[features | all_features], [labels | all_labels]}
      end)
      |> then(fn {x, y} -> {Nx.tensor(x), Nx.tensor(y)} end)

    model = Scholar.NaiveBayes.Complement.fit(x, y, num_classes: num_categories)
    {model, all_game_types, all_game_names}
  end

  def gameplay_types() do
    Repo.run_sql("""
    SELECT DISTINCT unnest(gameplay_types) AS gameplay_type
    FROM gameplays
    WHERE top_rated = true
    ORDER BY gameplay_type;
    """)
    |> then(& &1.rows)
    |> Enum.map(&List.first/1)
  end

  defp game_names() do
    Repo.run_sql("""
    SELECT DISTINCT game_name AS gameplay_type
    FROM gameplays
    WHERE top_rated = true
    ORDER BY game_name;
    """)
    |> then(& &1.rows)
    |> Enum.map(&List.first/1)
  end
end
