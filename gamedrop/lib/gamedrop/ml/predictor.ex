defmodule Gamedrop.Ml.Predictor do
  alias Gamedrop.Repo

  @all_budgets [1, 2, 3]

  def create_model() do
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

    Scholar.NaiveBayes.Complement.fit(x, y, num_classes: num_categories)
  end

  def predict(budget, game_types, model) do
    all_game_types = gameplay_types()
    all_game_names = game_names()

    x =
      Nx.concatenate({
        Tx.one_hot_encode(budget, @all_budgets),
        Tx.multi_hot_encode(game_types, all_game_types)
      })
      |> Nx.to_list()

    apply(model.__struct__, :predict, [model, Nx.tensor([x])])
    |> Nx.to_list()
    |> List.first()
    |> then(&Enum.fetch(all_game_names, &1))
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
