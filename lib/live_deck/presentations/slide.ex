defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """

  alias LiveDeck.Presentations.Config

  defstruct [
    :filename,
    :background_color,
    :title,
    :position
  ]

  @type title :: String.t()

  def all do
    for {slide, position} <- Config.slides() |> Enum.with_index() do
      struct = struct(__MODULE__, slide)

      %__MODULE__{
        struct
        | title: format_title(slide[:title] || slide.filename),
          position: position
      }
    end
  end

  defp format_title(filename) do
    filename
    |> String.replace(".html", "")
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(fn word -> String.capitalize(word) end)
    |> Enum.join(" ")
  end
end
