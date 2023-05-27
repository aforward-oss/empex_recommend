defmodule Pizzeria.Booking.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :datetime, :naive_datetime
    field :guests, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:name, :datetime, :guests])
    |> validate_required([:name, :datetime, :guests])
  end
end
