defmodule Pizzeria.Repo do
  use Ecto.Repo,
    otp_app: :pizzeria,
    adapter: Ecto.Adapters.Postgres

  alias Ecto.Adapters.SQL

  def run_sql(sql, params \\ []) do
    SQL.query!(__MODULE__, sql, params)
  end
end
