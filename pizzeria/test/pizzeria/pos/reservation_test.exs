defmodule Pizzeria.Pos.ResevationTest do
  use Pizzeria.DataCase

  alias Pizzeria.Pos

  describe "reservations" do
    alias Pizzeria.Pos.Reservation

    import Pizzeria.PosFixtures

    @invalid_attrs %{datetime: nil, guests: nil, name: nil}

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Pos.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Pos.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      valid_attrs = %{datetime: ~N[2023-05-26 22:22:00], guests: 42, name: "some name"}

      assert {:ok, %Reservation{} = reservation} = Pos.create_reservation(valid_attrs)
      assert reservation.datetime == ~N[2023-05-26 22:22:00]
      assert reservation.guests == 42
      assert reservation.name == "some name"
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{datetime: ~N[2023-05-27 22:22:00], guests: 43, name: "some updated name"}

      assert {:ok, %Reservation{} = reservation} =
               Pos.update_reservation(reservation, update_attrs)

      assert reservation.datetime == ~N[2023-05-27 22:22:00]
      assert reservation.guests == 43
      assert reservation.name == "some updated name"
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_reservation(reservation, @invalid_attrs)
      assert reservation == Pos.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Pos.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Pos.change_reservation(reservation)
    end
  end

  describe "num_reservations_tonight/1" do
    test "none" do
      assert Pizzeria.Pos.num_reservations_tonight() == 0
    end

    test "some" do
      Pos.create_reservation(%{datetime: NaiveDateTime.utc_now(), name: "A", guests: 1})
      assert Pizzeria.Pos.num_reservations_tonight() == 1
    end
  end

  describe "num_reservations_on/1" do
    test "none" do
      assert Pizzeria.Pos.num_reservations_on(~D[2023-06-03]) == 0
    end

    test "some" do
      Pos.create_reservation(%{datetime: ~N[2023-06-04 22:22:00], name: "A", guests: 1})
      assert Pizzeria.Pos.num_reservations_on(~D[2023-06-04]) == 1

      Pos.create_reservation(%{datetime: ~N[2023-06-04 22:22:00], name: "A", guests: 1})
      Pos.create_reservation(%{datetime: ~N[2023-06-04 22:22:00], name: "A", guests: 1})
      assert Pizzeria.Pos.num_reservations_on(~D[2023-06-04]) == 3
      assert Pizzeria.Pos.num_reservations_on("2023-06-04") == 3
    end
  end
end
