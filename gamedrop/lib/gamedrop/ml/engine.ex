defmodule Gamedrop.Ml.Engine do
  alias Gamedrop.Repo
  alias Gamedrop.Ml.Engine
  alias Scholar.NaiveBayes.Complement, as: Algorithm

  @all_budgets [1, 2, 3]

  def predict(_, {nil, _}), do: nil

  def predict(features, {model, opts}) do
    x =
      [:budget, :game_types]
      |> Enum.map(fn f -> Map.get(features, f) || Map.get(features, "#{f}") end)
      |> feature_to_tensor(opts)
      |> Nx.reshape({1, :auto})

    all_game_names = Keyword.get(opts, :all_game_names, [])

    apply(model.__struct__, :predict, [model, x])
    |> Nx.to_list()
    |> List.first()
    |> then(&Enum.fetch!(all_game_names, &1))
  end

  def train() do
    all_game_types = gameplay_types()
    all_game_names = game_names()

    opts = [
      all_budgets: @all_budgets,
      all_game_types: all_game_types,
      all_game_names: all_game_names
    ]

    {x, y, num_features} =
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
      |> Enum.reduce({nil, nil, nil}, fn [b, t, g], {x, y, n} ->
        features = Engine.feature_to_tensor([b, t], opts)
        label = Tx.category_encode(g, all_game_names) |> Nx.reshape({1})

        if is_nil(x) do
          {n} = Nx.shape(features)
          {features, label, n}
        else
          {Nx.concatenate([x, features]), Nx.concatenate([y, label]), n}
        end
      end)

    x = Nx.reshape(x, {:auto, num_features})
    num_classes = Enum.count(all_game_names)

    model = Algorithm.fit(x, y, num_classes: num_classes)

    {model, opts}
  end

  def feature_to_tensor([budget, game_types], opts) do
    all_budgets = Keyword.get(opts, :all_budgets, [])
    all_game_types = Keyword.get(opts, :all_game_types, [])

    Nx.concatenate([
      Tx.one_hot_encode(budget, all_budgets),
      Tx.multi_hot_encode(game_types, all_game_types, missing: :ignore)
    ])
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
