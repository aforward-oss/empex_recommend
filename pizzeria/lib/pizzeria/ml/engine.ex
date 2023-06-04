defmodule Pizzeria.Ml.Engine do
  alias Pizzeria.Analytics
  alias Pizzeria.Ml.Predictor, as: ML
  alias Scholar.Linear.LinearRegression, as: LR

  def dataset(), do: dataset({nil, nil})

  def dataset(daterange) do
    pizza_doughs =
      Analytics.pizza_doughs_by_date(daterange)
      |> Enum.map(&{&1.date, &1.num})
      |> Enum.into(%{})

    Analytics.reservations_by_date(daterange)
    |> Enum.reject(&Enum.member?(["Friday", "Saturday"], &1.day_of_week))
    |> Enum.map(&[&1.num, pizza_doughs[&1.date]])
    |> Enum.reject(fn [_num_resi, num_pizza] -> is_nil(num_pizza) end)
    |> Nx.tensor()
    |> then(fn data ->
      features = data[[.., 0..0]]
      labels = data[[.., 1]]
      {features, labels}
    end)
  end

  def train(), do: dataset() |> train()

  def train({features, labels}), do: LR.fit(features, labels)

  def save_model(), do: save_model(train(), ML.model_filename())

  def save_model(model, path) do
    model
    |> Nx.serialize()
    |> then(&File.write!(path, &1))
  end
end
