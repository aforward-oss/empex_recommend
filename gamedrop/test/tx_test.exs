defmodule TxTest do
  use ExUnit.Case, async: true
  doctest Tx

  describe "one_hot_encode/2" do
    test "acceptable values" do
      data = Nx.tensor([9, 3, 3]) |> Nx.new_axis(-1)

      assert Tx.one_hot_encode(data, [3, 9]) ==
               Nx.tensor([[0, 1], [1, 0], [1, 0]], type: {:u, 8})
    end

    test "digits" do
      data = Nx.tensor([9, 3]) |> Nx.new_axis(-1)

      assert Tx.one_hot_encode(data, :digits) ==
               Nx.tensor([[0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [0, 0, 0, 1, 0, 0, 0, 0, 0, 0]],
                 type: {:u, 8}
               )
    end
  end
end
