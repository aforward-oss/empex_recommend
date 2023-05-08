defmodule Gamegifting.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :system_name, :string
      add :date_released, :date
      add :genre, :string
      add :difficulty, :integer

      timestamps()
    end

    create index(:games, [:name])
    create index(:games, [:system_name])
    create index(:games, [:genre])
    create index(:games, [:difficulty])
  end
end
