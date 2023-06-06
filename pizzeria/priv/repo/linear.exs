# Run this script using
#
#     mix run priv/repo/linear.exs
#

alias Pizzeria.Repo
alias Pizzeria.Pos.{Reservation, Order}

Repo.delete_all(Reservation)
Repo.delete_all(Order)

sample_names = [
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

dates = [
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

for {m, d} <- dates,
    n <- 1..d do
  month = String.pad_leading("#{m}", 2, "0")
  day = String.pad_leading("#{n}", 2, "0")
  {:ok, datetime} = NaiveDateTime.from_iso8601("2023-#{month}-#{day}T07:00:00")
  num_resi = :rand.uniform(60) - 1

  if num_resi > 0 do
    for _ <- 1..num_resi do
      Repo.insert!(%Reservation{
        name: Enum.random(sample_names),
        guests: :rand.uniform(6),
        datetime: datetime
      })
    end

    weight = 2 + (:random.uniform() * 0.6 - 0.3)
    bias = 5 + (:random.uniform() * 0.8 - 0.4)

    num_pizzas = round(weight * num_resi + bias)

    if !is_nil(num_pizzas) do
      for _ <- 1..num_pizzas do
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
  end
end