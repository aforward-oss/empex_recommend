# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pizzeria.Repo.insert!(%Pizzeria.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pizzeria.Repo
alias Pizzeria.Pos.{Reservation, Order}

Repo.delete_all(Reservation)
Repo.delete_all(Order)

sample_data = [
  {"2023-05-22", 12, 36},
  {"2023-05-23", 20, 72},
  {"2023-05-24", 18, 68},
  {"2023-05-25", 30, 82},
  {"2023-05-26", 0, 98},
  {"2023-05-27", 2, 168},
  {"2023-05-28", 24, 75}
]

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

for {date, num_resi, num_pizzas} <- sample_data do
  {:ok, datetime} = NaiveDateTime.from_iso8601("#{date}T07:00:00")

  if num_resi > 0 do
    for _ <- 1..num_resi do
      Repo.insert!(%Reservation{
        name: Enum.random(sample_names),
        guests: :rand.uniform(6),
        datetime: datetime
      })
    end
  end

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
