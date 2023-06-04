defmodule Gamedrop.Ml.Worker do
  use GenServer
  alias Gamedrop.Ml.Engine

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    :timer.send_after(10_000, self(), :train)
    {:ok, {nil, nil}}
  end

  def predict(features) do
    {:ok, answer} = GenServer.call(__MODULE__, {:predict, features})
    answer
  end

  def train(), do: GenServer.cast(__MODULE__, :train)

  def handle_call({:predict, features}, _from, state) do
    result = Engine.predict(features, state)
    {:reply, result, state}
  end

  def handle_cast(:train, _state) do
    {:noreply, Engine.train()}
  end

  def handle_info(:train, _state) do
    {:noreply, Engine.train()}
  end
end
