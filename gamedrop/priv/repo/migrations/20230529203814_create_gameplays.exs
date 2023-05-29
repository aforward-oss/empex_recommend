defmodule Gamedrop.Repo.Migrations.CreateGameplays do
  use Ecto.Migration

  def change do
    create table(:gameplays) do
      add :console_name, :string
      add :game_name, :string
      add :rental_cost, :decimal
      add :gameplay_types, {:array, :string}
      add :top_rated, :boolean, default: false, null: false

      timestamps()
    end
  end
end
