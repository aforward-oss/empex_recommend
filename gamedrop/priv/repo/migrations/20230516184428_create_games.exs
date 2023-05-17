defmodule Gamedrop.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :game_name, :string
      add :console_name, :string
      add :release_date, :date
      add :developer, :string
      add :genre, :string
      add :difficulty, :integer
      add :gameplay_rating, :integer
      add :maturity_rating, :string
      add :multiplayer, :boolean
      add :player_mode, :string
      add :description, :text

      timestamps()
    end

    create index(:games, [:game_name])
    create index(:games, [:console_name])
    create index(:games, [:developer])
    create index(:games, [:genre])
    create index(:games, [:difficulty])
    create index(:games, [:gameplay_rating])
    create index(:games, [:maturity_rating])
    create index(:games, [:multiplayer])
    create index(:games, [:player_mode])
  end
end
