defmodule PizzeriaWeb.ReservationController do
  use PizzeriaWeb, :controller

  alias Pizzeria.Booking
  alias Pizzeria.Booking.Reservation

  def index(conn, _params) do
    reservations = Booking.list_reservations()
    render(conn, :index, reservations: reservations)
  end

  def new(conn, _params) do
    changeset = Booking.change_reservation(%Reservation{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    case Booking.create_reservation(reservation_params) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation created successfully.")
        |> redirect(to: ~p"/reservations/#{reservation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Booking.get_reservation!(id)
    render(conn, :show, reservation: reservation)
  end

  def edit(conn, %{"id" => id}) do
    reservation = Booking.get_reservation!(id)
    changeset = Booking.change_reservation(reservation)
    render(conn, :edit, reservation: reservation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reservation" => reservation_params}) do
    reservation = Booking.get_reservation!(id)

    case Booking.update_reservation(reservation, reservation_params) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation updated successfully.")
        |> redirect(to: ~p"/reservations/#{reservation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, reservation: reservation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Booking.get_reservation!(id)
    {:ok, _reservation} = Booking.delete_reservation(reservation)

    conn
    |> put_flash(:info, "Reservation deleted successfully.")
    |> redirect(to: ~p"/reservations")
  end
end
