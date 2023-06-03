defmodule Pizzeria.Pos do
  @moduledoc """
  The Point of Sale (POS) context.
  """

  import Ecto.Query, warn: false
  alias Pizzeria.Repo

  alias Pizzeria.Pos.{Reservation, Order}

  @doc """
  Returns the list of reservations.

  ## Examples

      iex> list_reservations()
      [%Reservation{}, ...]

  """
  def list_reservations do
    from(t in Reservation,
      order_by: [desc: t.datetime]
    )
    |> Repo.all()
  end

  @doc """
  How many reservations for the provided date?
  """
  def num_reservations_on(date) when is_binary(date) do
    date
    |> Date.from_iso8601!()
    |> num_reservations_on()
  end

  def num_reservations_on(date) do
    Repo.run_sql(
      """
      SELECT count(*)
      FROM reservations
      WHERE date(datetime) = $1
      """,
      [date]
    )
    |> then(& &1.rows)
    |> case do
      [[n]] -> n
    end
  end

  @doc """
  Gets a single reservation.

  Raises `Ecto.NoResultsError` if the Reservation does not exist.

  ## Examples

      iex> get_reservation!(123)
      %Reservation{}

      iex> get_reservation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reservation!(id), do: Repo.get!(Reservation, id)

  @doc """
  Creates a reservation.

  ## Examples

      iex> create_reservation(%{field: value})
      {:ok, %Reservation{}}

      iex> create_reservation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reservation(attrs \\ %{}) do
    %Reservation{}
    |> Reservation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reservation.

  ## Examples

      iex> update_reservation(reservation, %{field: new_value})
      {:ok, %Reservation{}}

      iex> update_reservation(reservation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reservation(%Reservation{} = reservation, attrs) do
    reservation
    |> Reservation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reservation.

  ## Examples

      iex> delete_reservation(reservation)
      {:ok, %Reservation{}}

      iex> delete_reservation(reservation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reservation(%Reservation{} = reservation) do
    Repo.delete(reservation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reservation changes.

  ## Examples

      iex> change_reservation(reservation)
      %Ecto.Changeset{data: %Reservation{}}

  """
  def change_reservation(%Reservation{} = reservation, attrs \\ %{}) do
    Reservation.changeset(reservation, attrs)
  end

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end
end
