defmodule Gamedrop.Ml.Worker do
  use GenServer

  alias Gamedrop.Ml.Engine
  alias Gamedrop.Ml.Predictor, as: ML

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, load()}
  end

  def refresh() do
    state = Engine.train() |> save()
    GenServer.call(__MODULE__, {:refresh, state})
  end

  def predict(features), do: GenServer.call(__MODULE__, {:predict, features})

  def opts(), do: GenServer.call(__MODULE__, :opts)

  def handle_call({:refresh, state}, _from, _state) do
    {:reply, state, state}
  end

  def handle_call({:predict, features}, _from, state) do
    result = ML.predict(features, state)
    {:reply, result, state}
  end

  def handle_call(:opts, _from, {_model, opts} = state) do
    {:reply, opts, state}
  end

  defp load(), do: Engine.load_if(ML.model_filename())

  defp save(model_state), do: Engine.save_if(model_state, ML.model_filename())
end
