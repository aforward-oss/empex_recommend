defmodule Gamedrop.Pos.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :console_name, :string
    field :description, :string
    field :developer, :string
    field :difficulty, :integer
    field :game_name, :string
    field :gameplay_rating, :integer
    field :genre, :string
    field :maturity_rating, :string
    field :multiplayer, :boolean, default: false
    field :player_mode, :string
    field :release_date, :date

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:game_name, :console_name, :release_date, :developer, :genre, :difficulty, :gameplay_rating, :maturity_rating, :multiplayer, :player_mode, :description])
    |> validate_required([:game_name, :console_name, :release_date, :developer, :genre, :difficulty, :gameplay_rating, :maturity_rating, :multiplayer, :player_mode, :description])
  end
end
