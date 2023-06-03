defmodule Pizzeria.Ml.Predictor do
  alias Scholar.Linear.LinearRegression, as: LR

  @filename "./priv/model.nx"
  @model File.read!(@filename) |> Nx.deserialize()

  def model_filename(), do: @filename
  def model(), do: @model

  def predict(num_resi, model \\ @model) do
    model
    |> LR.predict(Nx.tensor([num_resi]))
    |> Nx.to_number()
    |> Float.round(0)
  end
end
