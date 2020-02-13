defmodule LiveDeck.Repo do
  use Ecto.Repo,
    otp_app: :live_deck,
    adapter: Ecto.Adapters.Postgres
end
