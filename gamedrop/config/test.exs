import Config

config :gamedrop,
  calculating_sleep: 10,
  refresh_on_modify: false

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :gamedrop, Gamedrop.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "gamedrop_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gamedrop, GamedropWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Le7cAv0M9STbYTFOnyuVKe9bz6MH7VuWc9sE6mDwgPlOYdg0CoWVy/oHnGD4E+a+",
  server: false

# In test we don't send emails.
config :gamedrop, Gamedrop.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
