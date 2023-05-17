defmodule Gamedrop.Models.Game do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Gamedrop.Repo
  alias Gamedrop.Models.Game, as: Model

  schema "games" do
    field :game_name, :string
    field :console_name, :string
    field :release_date, :date
    field :developer, :string
    field :genre, :string
    field :difficulty, :integer
    field :gameplay_rating, :integer
    field :maturity_rating, :string
    field :multiplayer, :boolean
    field :player_mode, :string
    field :description, :string

    timestamps()
  end

  @fields [
    :game_name,
    :console_name,
    :release_date,
    :developer,
    :genre,
    :difficulty,
    :gameplay_rating,
    :maturity_rating,
    :multiplayer,
    :player_mode,
    :description
  ]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:game_name])
  end

  def all() do
    from(
      t in Model,
      order_by: t.game_name
    )
    |> Repo.all()
  end

  def find(game_name) do
    Repo.get_by(Model, game_name: game_name)
  end

  def add(params) do
    %Model{}
    |> changeset(params)
    |> Repo.insert!()
  end

  def update(platform, params) do
    platform
    |> changeset(params)
    |> Repo.update!()
  end

  def upsert(params) do
    case find(params[:game_name]) do
      nil -> add(params)
      found -> update(found, params)
    end
  end
end
