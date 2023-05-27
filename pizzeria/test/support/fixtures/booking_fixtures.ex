defmodule Pizzeria.BookingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pizzeria.Booking` context.
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
      |> Pizzeria.Booking.create_reservation()

    reservation
  end
end
