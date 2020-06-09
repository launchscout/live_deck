defmodule LiveDeck.Presentations.Config do
  @moduledoc """
    Use this Configuration to adjust Presentation settings, including position, background color, and title of slides.
  """

  @default_background "back--1"
  @default_slides [
    %{
      filename: "template_title.html",
      title: "LiveDeck Introduction",
      background_color: "back--2"
    },
    %{
      filename: "template_right_aside.html",
      title: "Created with Elixir, Phoenix, and LiveView",
      background_color: "back--3"
    },
    %{filename: "template_page_split.html", title: "Created For Developers"},
    %{
      filename: "template_quote.html",
      title: "Better Than the Rest",
      background_color: "back--3"
    },
    %{filename: "template_3_col.html", title: "What We Used"},
    %{filename: "template_bullet_list.html", title: "Easy To Use"},
    %{
      filename: "template_side_image.html",
      title: "Configure Your Deck",
      background_color: "back--3"
    },
    %{filename: "template_left_aside.html", title: "Deck remote", background_color: "back--2"},
    %{filename: "template_2_col.html", title: "Configure Your Deck", background_color: "back--3"},
    %{
      filename: "template_code.html",
      title: "Using The Config File"
    },
    %{filename: "template_quote_alt.html"},
    %{filename: "template_4_col.html", title: "LiveDeck Roadmap"},
    %{filename: "template_full_image.html"}
  ]
  # This is for testing purposes
  @dummy List.first(@default_slides).filename

  def slides do
    @default_slides
    |> insert_notes()
    |> insert_background_color()
  end

  def insert_notes(slides) do
    slides
    |> Enum.map(fn %{filename: filename} = config ->
      Map.put(config, :notes, notes(for: filename))
    end)
  end

  defp insert_background_color(slides) do
    slides
    |> Enum.map(fn config ->
      case config[:background_color] do
        nil -> Map.put(config, :background_color, @default_background)
        _ -> config
      end
    end)
  end

  defp notes(for: @dummy) do
    "Hi. I am your notes."
  end

  defp notes(for: "template_2_col.html") do
    "I am some more notes for your reading pleasure while you are presenting."
  end

  defp notes(_), do: ""
end
