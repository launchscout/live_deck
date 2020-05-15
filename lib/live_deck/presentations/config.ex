defmodule LiveDeck.Presentations.Config do
  @moduledoc """
    Use this Configuration to adjust Presentation settings, including position, background color, and title of slides.
  """

  @default_theme "live-deck-theme"
  @default_slides [
    %{filename: "template_4_col.html", title: "overridden title"},
    %{filename: "template_3_col.html", background_color: "overridden color"},
    %{filename: "template_quote.html"},
    %{filename: "template_2_col.html"},
    %{filename: "template_right_aside.html"},
    %{filename: "template_title.html"},
    %{filename: "template_side_image.html"},
    %{filename: "template_page_split.html"},
    %{filename: "template_quote_alt.html"},
    %{filename: "template_bullet_list.html"},
    %{filename: "template_full_image.html"},
    %{filename: "template_left_aside.html"}
  ]
  # This is for testing purposes
  @dummy List.first(@default_slides).filename

  def slides do
    @default_slides
    |> insert_notes()
  end

  def insert_notes(slides) do
    slides
    |> Enum.map(fn %{filename: filename} = config ->
      Map.put(config, :notes, notes(for: filename))
    end)
  end

  defp notes(for: @dummy) do
    "Hi. I am your notes."
  end

  defp notes(_), do: ""
end
