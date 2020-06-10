![alt text](assets/static/images/live-deck-logo-full.png?raw=true=300x "Live Deck Logo")

# LiveDeck
LiveDeck is an interactive presentation deck built with Elixir, Phoenix, and LiveView. The web-based slide deck features provide the ability to display real-time data and for engaging audience interactions. The deck comes with several themes and slides templates to create beautiful presentations out of the box.

![alt text](assets/static/images/live-deck-sample-1.jpg?raw=true=250x "Live Deck Remote")
![alt text](assets/static/images/live-deck-sample-2.jpg?raw=true=250x "Live Deck Default Slide Theme")
![alt text](assets/static/images/live-deck-sample-3.jpg?raw=true=250x "Live Deck Presenter Mode")

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

#### CI

CI will run the following commands on the codebase:

1. `mix credo`
2. `mix format --check-formatted`
3. `mix coveralls --trace` (tests + test coverage)
4. `mix dialyzer` (static type analysis)

#### Local Development

Run `mix check` to check code quality.

It checks compiler, credo, dialyzer, ex_doc, ex_unit, formatter, npm_test and sobelow by default. `excoveralls` is added to config file. To skip any check add `{:toolname, false},` in the tools array of `.check.exs` file. To add custom command on a tool add `{:toolname, command: "mix command"}` in the tools array of `.check.exs` file.

For more info visit:
https://github.com/karolsluszniak/ex_check
https://hexdocs.pm/ex_check/0.9.0/Mix.Tasks.Check.html#content

## Deck Conifguration
The deck theme, slide order, slide backgrounds, and slide notes can be configured in the ***lib/live_deck/presentations/config.ex*** file. Read more about the the configuration settings [here](https://github.com/gaslight/live_deck/wiki/Deck-Configuration).

## Deck Themes
LiveDeck includes beautiful themes that change the colors and typeography of the whole deck. Themes also include several background options for slides. View all the deck themes [here](https://github.com/gaslight/live_deck/wiki/Deck-Theme).

## Deck Templates
LiveDeck includes many different slide layouts we call slide templates. View all the deck templates [here](https://github.com/gaslight/live_deck/wiki/Deck-Slide-Templates).

## Deck Remote and Presenter Mode
Your presentation can be controlled through a seperate webpage we call the remote. The remote adapts to presenter mode when viewing on a desktop or laptop. Learn more about the deck remote [here](https://github.com/gaslight/live_deck/wiki/Deck-Remote-and-Presentation-Mode).

## More Info

  * Phoenix Docs: https://hexdocs.pm/phoenix
  * Phoenix LiveView Docs: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html
  * Elixir Docs: https://hexdocs.pm/elixir/Enum.html
  * Ecto Docs: https://hexdocs.pm/ecto/Ecto.html
  * Ecto SQL Docs: https://hexdocs.pm/ecto_sql/Ecto.Adapters.SQL.html#content
  * Erlang Docs: https://erlang.org/doc/search/

## License
See the [LICENSE](/LICENSE.md) file for license rights and limitations (MIT).
