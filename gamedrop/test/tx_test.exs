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

    test "strings" do
      assert Tx.one_hot_encode("a", ["a", "b", "c"]) ==
               Nx.tensor([1, 0, 0], type: {:u, 8})

      assert Tx.one_hot_encode("a", ["a", "b", "c"], missing: :error) ==
               Nx.tensor([1, 0, 0], type: {:u, 8})
    end

    test "nil string" do
      assert Tx.one_hot_encode(nil, ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([0, 0, 0], type: {:s, 64})
    end

    test "unknown strings are mapped as all 0s" do
      assert Tx.one_hot_encode("a", ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([1, 0, 0], type: {:u, 8})

      assert Tx.one_hot_encode("x", ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([0, 0, 0], type: {:s, 64})
    end

    test "include 'other' if unknown" do
      assert Tx.one_hot_encode("a", ["a", "b", "c"], missing: :other) ==
               Nx.tensor([0, 1, 0, 0], type: {:u, 8})

      assert Tx.one_hot_encode("x", ["a", "b", "c"], missing: :other) ==
               Nx.tensor([1, 0, 0, 0], type: {:u, 8})
    end
  end

  describe "multi_hot_encode/2" do
    test "strings" do
      assert Tx.multi_hot_encode(["a", "b"], ["a", "b", "c"]) ==
               Nx.tensor([1, 1, 0], type: {:u, 8})

      assert Tx.multi_hot_encode(["c", "b"], ["a", "b", "c"]) ==
               Nx.tensor([0, 1, 1], type: {:u, 8})
    end

    test "no values (default)" do
      assert Tx.multi_hot_encode(nil, ["a", "b", "c"]) ==
               Nx.tensor([0, 0, 0], type: {:s, 64})

      assert Tx.multi_hot_encode([], ["a", "b", "c"]) ==
               Nx.tensor([0, 0, 0], type: {:s, 64})
    end

    test "no values (ignore)" do
      assert Tx.multi_hot_encode(nil, ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([0, 0, 0], type: {:s, 64})

      assert Tx.multi_hot_encode([], ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([0, 0, 0], type: {:s, 64})
    end

    test "no values (other)" do
      assert Tx.multi_hot_encode(nil, ["a", "b", "c"], missing: :other) ==
               Nx.tensor([1, 0, 0, 0], type: {:s, 64})

      assert Tx.multi_hot_encode([], ["a", "b", "c"], missing: :other) ==
               Nx.tensor([1, 0, 0, 0], type: {:s, 64})
    end

    test "nil strings are mapped as all 0s" do
      assert Tx.multi_hot_encode(["c", nil], ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([0, 0, 1], type: {:s, 64})
    end

    test "unknown strings are mapped as all 0s" do
      assert Tx.multi_hot_encode(["c", "x"], ["a", "b", "c"], missing: :ignore) ==
               Nx.tensor([0, 0, 1], type: {:s, 64})
    end

    test "include 'other' if unknown" do
      assert Tx.multi_hot_encode(["c", "x"], ["a", "b", "c"], missing: :other) ==
               Nx.tensor([1, 0, 0, 1], type: {:u, 8})
    end
  end

  describe "category_encode/2" do
    test "strings" do
      assert Tx.category_encode("b", ["a", "b", "c"]) ==
               Nx.tensor(2, type: {:s, 64})

      assert Tx.category_encode("c", ["a", "b", "c"]) ==
               Nx.tensor(3, type: {:s, 64})
    end

    test "unknown strings" do
      assert Tx.category_encode("c", ["a", "b", "c"], strict: false) ==
               Nx.tensor(3, type: {:s, 64})

      assert Tx.category_encode("x", ["a", "b", "c"], strict: false) ==
               Nx.tensor(0, type: {:s, 64})
    end
  end
end
