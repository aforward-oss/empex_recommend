defmodule Pizzeria.Repo do
  use Ecto.Repo,
    otp_app: :pizzeria,
    adapter: Ecto.Adapters.Postgres
end
