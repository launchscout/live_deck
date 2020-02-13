use Mix.Config

# Configure your database
config :live_deck, LiveDeck.Repo,
  username: "postgres",
  password: "postgres",
  database: "live_deck_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Test setup
config :live_deck, path_module: LiveDeck.Fakes.Path

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_deck, LiveDeckWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
