defmodule PizzeriaWeb.ReservationController do
  use PizzeriaWeb, :controller

  alias Pizzeria.Pos
  alias Pizzeria.Pos.Reservation

  def index(conn, _params) do
    reservations = Pos.list_reservations()
    render(conn, :index, reservations: reservations)
  end

  def new(conn, _params) do
    changeset = Pos.change_reservation(%Reservation{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    case Pos.create_reservation(reservation_params) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation created successfully.")
        |> redirect(to: ~p"/reservations/#{reservation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Pos.get_reservation!(id)
    render(conn, :show, reservation: reservation)
  end

  def edit(conn, %{"id" => id}) do
    reservation = Pos.get_reservation!(id)
    changeset = Pos.change_reservation(reservation)
    render(conn, :edit, reservation: reservation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reservation" => reservation_params}) do
    reservation = Pos.get_reservation!(id)

    case Pos.update_reservation(reservation, reservation_params) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation updated successfully.")
        |> redirect(to: ~p"/reservations/#{reservation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, reservation: reservation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Pos.get_reservation!(id)
    {:ok, _reservation} = Pos.delete_reservation(reservation)

    conn
    |> put_flash(:info, "Reservation deleted successfully.")
    |> redirect(to: ~p"/reservations")
  end
end
