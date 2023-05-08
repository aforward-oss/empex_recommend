defmodule Gamegifting.Models.Game do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Gamegifting.Repo
  alias Gamegifting.Models.Game, as: Model

  schema "games" do
    field :name, :string
    field :system_name, :string
    field :date_released, :date
    field :genre, :string
    field :difficulty, :integer

    timestamps()
  end

  @fields [:name, :system_name, :date_released, :genre, :difficulty]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:name])
  end

  def all() do
    from(
      t in Model,
      order_by: t.name
    )
    |> Repo.all()
  end

  def find(name) do
    Repo.get_by(Model, name: name)
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
    case find(params[:name]) do
      nil -> add(params)
      found -> update(found, params)
    end
  end
end
