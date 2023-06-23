defmodule Gamedrop.Ml.Predictor do
  @filename "priv/model.nx"
  @model_state File.read!(@filename)
               |> :erlang.binary_to_term()
               |> then(fn {model, opts} -> {Nx.deserialize(model), opts} end)

  def model_filename(), do: @filename
  def model_state(), do: @model_state

  def predict(features), do: predict(features, 1, model_state())

  def predict(features, n) when is_integer(n), do: predict(features, n, model_state())

  def predict(features, {model, opts}), do: predict(features, 1, {model, opts})

  def predict(features, n, {model, opts}) do
    x = to_x(features, opts)
    all_game_names = Keyword.get(opts, :all_game_names, [])

    if n == 1 do
      apply(model.__struct__, :predict, [model, x])
      |> Nx.to_list()
      |> List.first()
      |> then(&Enum.fetch!(all_game_names, &1))
    else
      apply(model.__struct__, :predict_probability, [model, x])
      |> Nx.to_flat_list()
      |> Enum.with_index()
      |> Enum.sort(fn {a, x}, {b, y} ->
        if a == b do
          x < y
        else
          a > b
        end
      end)
      |> Enum.take(n)
      |> Enum.map(fn {_, i} -> Enum.fetch!(all_game_names, i) end)
    end
  end

  def to_x(features, opts) do
    [:budget, :game_types]
    |> Enum.map(fn f -> Map.get(features, f) || Map.get(features, "#{f}") end)
    |> feature_to_tensor(opts)
    |> Nx.reshape({1, :auto})
  end

  def feature_to_tensor([budget, game_types], opts) do
    all_budgets = Keyword.get(opts, :all_budgets, [])
    all_game_types = Keyword.get(opts, :all_game_types, [])

    Nx.concatenate([
      Tx.one_hot_encode(budget, all_budgets),
      Tx.multi_hot_encode(game_types, all_game_types)
    ])
  end
end
