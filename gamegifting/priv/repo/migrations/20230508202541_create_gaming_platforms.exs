defmodule Gamegifting.Repo.Migrations.CreateGamingPlatforms do
  use Ecto.Migration

  def change do
    create table(:gaming_platforms) do
      add :company_name, :string
      add :system_name, :string
      add :date_released, :date
      add :company_website, :string
      timestamps
    end
  end
end
