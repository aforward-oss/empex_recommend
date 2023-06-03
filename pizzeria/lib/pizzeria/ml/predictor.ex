defmodule Pizzeria.Ml.Predictor do
  alias Pizzeria.Analytics
  alias Scholar.Linear.LinearRegression, as: LR

  @model_path "./priv/pizzeria.nx"
  @model File.read!(@model_path) |> Nx.deserialize()

  def create_model() do
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

  def model(:default), do: @model
  def model(:live), do: create_model()

  def predict(num_resi, model_type \\ :default) do
    model(model_type)
    |> LR.predict(Nx.tensor([num_resi]))
    |> Nx.to_number()
    |> Float.round(0)
  end

  def save_model(path \\ @model_path) do
    create_model()
    |> Nx.serialize()
    |> then(&File.write!(path, &1))
  end
end
