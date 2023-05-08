defmodule Gamegifting.Models.GamingPlatform do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Gamegifting.Repo
  alias Gamegifting.Models.GamingPlatform, as: Model

  schema "gaming_platforms" do
    field :company_name, :string
    field :system_name, :string
    field :date_released, :date
    field :company_website, :string

    timestamps()
  end

  @fields [:company_name, :system_name, :date_released, :company_website]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:system_name])
  end

  def all() do
    from(
      t in Model,
      order_by: t.system_name
    )
    |> Repo.all()
  end

  def find(name) do
    Repo.get_by(Model, system_name: name)
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
    case find(params[:system_name]) do
      nil -> add(params)
      found -> update(found, params)
    end
  end
end
