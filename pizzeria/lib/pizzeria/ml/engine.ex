defmodule Pizzeria.Ml.Engine do
  alias Pizzeria.Analytics
  alias Scholar.Linear.LinearRegression, as: LR

  def train() do
    pizza_doughs =
      Analytics.pizza_doughs_by_date()
      |> Enum.map(&{&1.date, &1.num})
      |> Enum.into(%{})

    Analytics.reservations_by_date()
    |> Enum.reject(&Enum.member?(["Friday", "Saturday"], &1.day_of_week))
    # For simplicity of demo assuming pizza doughs for every reservation date
    |> Enum.map(&[&1.num, pizza_doughs[&1.date]])
    |> Nx.tensor()
    |> then(fn data ->
      features = data[[.., 0..0]]
      label = data[[.., 1]]
      LR.fit(features, label)
    end)
  end

  def save_model(path) do
    train()
    |> Nx.serialize()
    |> then(&File.write!(path, &1))
  end
end
