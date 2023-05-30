defmodule Gamedrop.Pos.Console do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consoles" do
    field :company_name, :string
    field :company_website, :string
    field :console_name, :string
    field :release_date, :date

    timestamps()
  end

  @doc false
  def changeset(console, attrs) do
    console
    |> cast(attrs, [:company_name, :console_name, :release_date, :company_website])
    |> validate_required([:company_name, :console_name, :release_date, :company_website])
  end
end
