defmodule Pizzeria.MenuFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pizzeria.Menu` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        item_name: "some item_name",
        ordered_at: ~N[2023-05-26 22:50:00],
        quantity: 42,
        table_num: 42
      })
      |> Pizzeria.Menu.create_order()

    order
  end
end
