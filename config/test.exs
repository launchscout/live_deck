use Mix.Config

# Configure your database
config :live_deck, LiveDeck.Repo,
  username: "postgres",
  password: "postgres",
  database: "live_deck_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Test config
config :live_deck,
  path_module: LiveDeck.Fake.Path,
  file_module: LiveDeck.Fake.File

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_deck, LiveDeckWeb.Endpoint,
  http: [port: 4002],
  secret_key_base:
    System.get_env("SECRET_KEY_BASE") ||
      "B6l0Z1Jb1CYfqVed1oJNRlxWknzsNj4Cuqqr+iAVsPm7+ISaUzSzvOz6dSfSqmWt",
  live_view: [
    signing_salt:
      System.get_env("LIVE_VIEW_SALT") ||
        "B6l0Z1Jb1CYfqVed1oJNRlxWknzsNj4Cuqqr+iAVsPm7+ISaUzSzvOz6dSfSqmWt"
  ],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
