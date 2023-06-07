defmodule Pizzeria.Migrations.Seeds do
  alias Pizzeria.Repo
  alias Pizzeria.Pos.{Reservation, Order}

  @sample_names [
    "Andrew",
    "Michael",
    "Sarah",
    "Emma",
    "John",
    "Robert",
    "Jennifer",
    "Jessica",
    "Megan",
    "Emily",
    "Laura",
    "David",
    "Daniel",
    "James",
    "William",
    "Anthony",
    "Patricia",
    "Linda",
    "Barbara",
    "Elizabeth"
  ]

  @dates [
    {1, 31},
    {2, 28},
    {3, 31},
    {4, 30},
    {5, 31},
    {6, 30},
    {7, 31},
    {8, 31},
    {9, 30},
    {10, 31},
    {11, 30},
    {12, 31}
  ]

  def linear() do
    Repo.delete_all(Reservation)
    Repo.delete_all(Order)

    for {m, num} <- @dates,
        d <- 1..num do
      datetime = datetime(m, d)
      num_resi = :rand.uniform(60) - 1

      add_reservations(num_resi, datetime)

      if num_resi > 0 do
        weight = 2 + (:rand.uniform() * 0.6 - 0.3)
        bias = 5 + (:rand.uniform() * 0.8 - 0.4)
        num_pizzas = round(weight * num_resi + bias)
        add_pizzas(num_pizzas, datetime)
      end
    end
  end

  def logarithmic() do
    Repo.delete_all(Reservation)
    Repo.delete_all(Order)

    for {m, num} <- @dates,
        d <- 1..num do
      datetime = datetime(m, d)
      num_resi = :rand.uniform(60) - 1

      add_reservations(num_resi, datetime)

      if num_resi > 0 do
        weight = 10 + (:rand.uniform() * 0.1 - 0.5)
        bias = 15 + (:rand.uniform() * 2.0 - 1.0)
        num_pizzas = round(weight * :math.log2(num_resi) + bias)
        add_pizzas(num_pizzas, datetime)
      end
    end
  end

  def sample() do
    Repo.delete_all(Reservation)
    Repo.delete_all(Order)

    sample_data = [
      {"2023-05-22", 12, 36},
      {"2023-05-23", 20, 72},
      {"2023-05-24", 18, 68},
      {"2023-05-25", 30, 82},
      {"2023-05-26", nil, 98},
      {"2023-05-27", 2, 168},
      {"2023-05-28", 24, 75},
      {"2023-06-06", 14, nil},
      {"2023-06-07", 19, nil},
      {"2023-06-08", 24, nil},
      {"2023-06-09", 40, nil}
    ]

    for {date, num_resi, num_pizzas} <- sample_data do
      {:ok, datetime} = NaiveDateTime.from_iso8601("#{date}T07:00:00")
      add_reservations(num_resi, datetime)
      add_pizzas(num_pizzas, datetime)
    end
  end

  defp add_reservations(num_resi, datetime) do
    if !is_nil(num_resi) and num_resi > 0 do
      for _ <- 1..num_resi do
        add_reservation(datetime)
      end
    end
  end

  defp add_reservation(datetime) do
    Repo.insert!(%Reservation{
      name: Enum.random(@sample_names),
      guests: :rand.uniform(6),
      datetime: datetime
    })
  end

  defp datetime(m, d) do
    month = String.pad_leading("#{m}", 2, "0")
    day = String.pad_leading("#{d}", 2, "0")
    {:ok, datetime} = NaiveDateTime.from_iso8601("2023-#{month}-#{day}T07:00:00")
    datetime
  end

  defp add_pizzas(num_pizzas, datetime) do
    if !is_nil(num_pizzas) && num_pizzas > 0 do
      for _ <- 1..num_pizzas do
        add_pizza(datetime)
      end
    end
  end

  defp add_pizza(datetime) do
    table_num = :rand.uniform(100)

    Repo.insert!(%Order{
      item_name: "pizza",
      ordered_at: datetime,
      quantity: 1,
      table_num: table_num
    })

    Repo.insert!(%Order{
      item_name: "pop",
      ordered_at: datetime,
      quantity: :rand.uniform(4),
      table_num: table_num
    })
  end
end
