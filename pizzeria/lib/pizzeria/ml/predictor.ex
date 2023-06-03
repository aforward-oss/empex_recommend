defmodule Pizzeria.Ml.Predictor do
  alias Pizzeria.Ml.Engine
  alias Scholar.Linear.LinearRegression, as: LR

  @filename "./priv/model.nx"
  @model File.read!(@filename) |> Nx.deserialize()

  def model_filename(), do: @filename
  def model(), do: @model

  def model(:default), do: @model
  def model(:live), do: Engine.train()
  def model(asis), do: asis

  def predict(num_resi, model_type \\ :default) do
    model(model_type)
    |> LR.predict(Nx.tensor([num_resi]))
    |> Nx.to_number()
    |> Float.round(0)
  end
end
