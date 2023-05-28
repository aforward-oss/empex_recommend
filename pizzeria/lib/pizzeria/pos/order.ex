defmodule Pizzeria.Pos.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :item_name, :string
    field :ordered_at, :naive_datetime
    field :quantity, :integer
    field :table_num, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:item_name, :table_num, :quantity, :ordered_at])
    |> validate_required([:item_name, :table_num, :quantity, :ordered_at])
  end
end
