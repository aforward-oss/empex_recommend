defmodule Gamedrop.Repo do
  use Ecto.Repo,
    otp_app: :gamedrop,
    adapter: Ecto.Adapters.Postgres

  alias Ecto.Adapters.SQL

  def run_sql(sql, params \\ []) do
    SQL.query!(Gamedrop.Repo, sql, params)
  end
end
