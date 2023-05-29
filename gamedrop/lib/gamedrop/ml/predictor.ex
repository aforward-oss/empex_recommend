defmodule Gamedrop.Ml.Predictor do
  @model File.read!("./priv/model.nx") |> Nx.deserialize()

  def predict(x, y) do
    apply(@model.__struct__, :predict, [@model, Nx.tensor([x, y])])
    |> Nx.to_number()
    |> Float.round(2)
  end
end
