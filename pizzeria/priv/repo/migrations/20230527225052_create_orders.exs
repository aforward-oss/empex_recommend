defmodule Pizzeria.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :item_name, :string
      add :table_num, :integer
      add :quantity, :integer
      add :ordered_at, :naive_datetime

      timestamps()
    end
  end
end
