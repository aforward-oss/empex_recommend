defmodule Tx do
  def one_hot_encode(tensor, :digits) do
    one_hot_encode(tensor, 0..9 |> Enum.to_list())
  end

  def one_hot_encode(tensor, set) do
    Nx.equal(tensor, Nx.tensor(set))
  end
end
