defmodule Gamedrop.Pos.Gameplay do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gameplays" do
    field :console_name, :string
    field :game_name, :string
    field :gameplay_types, {:array, :string}
    field :rental_cost, :decimal
    field :top_rated, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(gameplay, attrs) do
    gameplay
    |> cast(attrs, [:console_name, :game_name, :rental_cost, :gameplay_types, :top_rated])
    |> validate_required([:console_name, :game_name, :rental_cost, :gameplay_types, :top_rated])
  end
end
