defmodule Pizzeria.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :name, :string
      add :datetime, :naive_datetime
      add :guests, :integer

      timestamps()
    end
  end
end
