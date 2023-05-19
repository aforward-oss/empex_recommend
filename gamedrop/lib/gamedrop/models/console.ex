defmodule Gamedrop.Models.Console do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Gamedrop.Repo
  alias Gamedrop.Models.Console, as: Model

  schema "consoles" do
    field :company_name, :string
    field :console_name, :string
    field :release_date, :date
    field :company_website, :string

    timestamps()
  end

  @fields [:company_name, :console_name, :release_date, :company_website]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:console_name])
  end

  def all() do
    from(
      t in Model,
      order_by: t.console_name
    )
    |> Repo.all()
  end

  def by_id(id) do
    Repo.get_by(Model, id: id)
  end

  def find(name) do
    Repo.get_by(Model, console_name: name)
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
    case find(params[:console_name] || params["console_name"]) do
      nil -> add(params)
      found -> update(found, params)
    end
  end
end
