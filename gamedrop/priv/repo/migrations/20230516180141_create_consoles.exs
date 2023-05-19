defmodule Gamedrop.Repo.Migrations.CreateConsoles do
  use Ecto.Migration

  def change do
    create table(:consoles) do
      add :company_name, :string
      add :console_name, :string
      add :release_date, :date
      add :company_website, :string
      timestamps()
    end

    create index(:consoles, [:company_name])
    create index(:consoles, [:console_name])
  end
end
