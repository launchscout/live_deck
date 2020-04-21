# LiveDeck
LiveDeck is an interactive presentation deck built with Elixir, Phoenix, and LiveView. The web-based slide deck features provide the ability to display real-time data and for engaging audience interactions.

[![Coverage Status](https://coveralls.io/repos/github/gaslight/live_deck/badge.svg)](https://coveralls.io/github/gaslight/live_deck)
[![CircleCI](https://circleci.com/gh/gaslight/live_deck.svg?style=svg)](https://circleci.com/gh/gaslight/live_deck)

## Getting Started

Run `asdf install` to pull in Erlang, Elixir, and Node versions.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix=assets install` (append `--force phoenix_live_view` to update the NPM Live View dependency if there has been an update to the phoenix_live_view mix dep since your last run of the project)
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Contributing

CI will run the following commands on the codebase:

1. `mix credo`
2. `mix format --check-formatted`
3. `mix coveralls --trace` (tests + test coverage)
4. `mix dialyzer` (static type analysis)

Run these commands as you are developing to catch any errors prior to running your commits through CI.

## More Info

  * Phoenix Docs: https://hexdocs.pm/phoenix
  * Phoenix LiveView Docs: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html
  * Elixir Docs: https://hexdocs.pm/elixir/Enum.html
  * Ecto Docs: https://hexdocs.pm/ecto/Ecto.html
  * Ecto SQL Docs: https://hexdocs.pm/ecto_sql/Ecto.Adapters.SQL.html#content
  * Erlang Docs: https://erlang.org/doc/search/
