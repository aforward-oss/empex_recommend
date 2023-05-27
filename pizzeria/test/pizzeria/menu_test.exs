defmodule Pizzeria.MenuTest do
  use Pizzeria.DataCase

  alias Pizzeria.Menu

  describe "orders" do
    alias Pizzeria.Menu.Order

    import Pizzeria.MenuFixtures

    @invalid_attrs %{item_name: nil, ordered_at: nil, quantity: nil, table_num: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Menu.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Menu.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{item_name: "some item_name", ordered_at: ~N[2023-05-26 22:50:00], quantity: 42, table_num: 42}

      assert {:ok, %Order{} = order} = Menu.create_order(valid_attrs)
      assert order.item_name == "some item_name"
      assert order.ordered_at == ~N[2023-05-26 22:50:00]
      assert order.quantity == 42
      assert order.table_num == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{item_name: "some updated item_name", ordered_at: ~N[2023-05-27 22:50:00], quantity: 43, table_num: 43}

      assert {:ok, %Order{} = order} = Menu.update_order(order, update_attrs)
      assert order.item_name == "some updated item_name"
      assert order.ordered_at == ~N[2023-05-27 22:50:00]
      assert order.quantity == 43
      assert order.table_num == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_order(order, @invalid_attrs)
      assert order == Menu.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Menu.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Menu.change_order(order)
    end
  end
end
