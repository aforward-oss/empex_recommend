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
    GenServer.cast(__MODULE__, :refresh)
  end

  def predict(features), do: predict(features, 1)

  def predict(features, n), do: GenServer.call(__MODULE__, {:predict, features, n})

  def opts(), do: GenServer.call(__MODULE__, :opts)

  def handle_cast(:refresh, _state) do
    state = Engine.train() |> save()
    {:noreply, state}
  end

  def handle_call({:predict, features, n}, _from, state) do
    result = ML.predict(features, n, state)
    {:reply, result, state}
  end

  def handle_call(:opts, _from, {_model, opts} = state) do
    {:reply, opts, state}
  end

  defp load(), do: Engine.load_if(ML.model_filename())

  defp save(model_state), do: Engine.save_if(model_state, ML.model_filename())
end
