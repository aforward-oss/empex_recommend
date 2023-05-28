defmodule Pizzeria.PosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pizzeria.Pos` context.
  """

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{
        datetime: ~N[2023-05-26 22:22:00],
        guests: 42,
        name: "some name"
      })
      |> Pizzeria.Pos.create_reservation()

    reservation
  end

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
      |> Pizzeria.Pos.create_order()

    order
  end
end
