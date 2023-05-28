defmodule Pizzeria.Pos.OrderTest do
  use Pizzeria.DataCase

  alias Pizzeria.Pos

  describe "orders" do
    alias Pizzeria.Pos.Order

    import Pizzeria.PosFixtures

    @invalid_attrs %{item_name: nil, ordered_at: nil, quantity: nil, table_num: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Pos.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Pos.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{
        item_name: "some item_name",
        ordered_at: ~N[2023-05-26 22:50:00],
        quantity: 42,
        table_num: 42
      }

      assert {:ok, %Order{} = order} = Pos.create_order(valid_attrs)
      assert order.item_name == "some item_name"
      assert order.ordered_at == ~N[2023-05-26 22:50:00]
      assert order.quantity == 42
      assert order.table_num == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()

      update_attrs = %{
        item_name: "some updated item_name",
        ordered_at: ~N[2023-05-27 22:50:00],
        quantity: 43,
        table_num: 43
      }

      assert {:ok, %Order{} = order} = Pos.update_order(order, update_attrs)
      assert order.item_name == "some updated item_name"
      assert order.ordered_at == ~N[2023-05-27 22:50:00]
      assert order.quantity == 43
      assert order.table_num == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_order(order, @invalid_attrs)
      assert order == Pos.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Pos.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Pos.change_order(order)
    end
  end
end
