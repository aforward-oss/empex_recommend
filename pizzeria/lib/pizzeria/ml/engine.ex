defmodule Pizzeria.Ml.Engine do
  alias Pizzeria.Analytics
  alias Pizzeria.Ml.Predictor, as: ML
  alias Scholar.Linear.LinearRegression, as: LR

  def train() do
    pizza_doughs =
      Analytics.pizza_doughs_by_date()
      |> Enum.map(&{&1.date, &1.num})
      |> Enum.into(%{})

    Analytics.reservations_by_date()
    |> Enum.reject(&Enum.member?(["Friday", "Saturday"], &1.day_of_week))
    |> Enum.map(&[&1.num, pizza_doughs[&1.date]])
    |> Enum.reject(fn [_num_resi, num_pizza] -> is_nil(num_pizza) end)
    |> Nx.tensor()
    |> then(fn data ->
      features = data[[.., 0..0]]
      label = data[[.., 1]]
      LR.fit(features, label)
    end)
  end

  def save_model(), do: save_model(train(), ML.model_filename())

  def save_model(model, path) do
    model
    |> Nx.serialize()
    |> then(&File.write!(path, &1))
  end
end
