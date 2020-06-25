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
    :position,
    :notes
  ]

  @type t :: %__MODULE__{
          filename: String.t(),
          background_color: String.t(),
          title: String.t(),
          position: non_neg_integer(),
          notes: String.t()
        }
  @type title :: String.t()

  @spec all() :: list(t())
  def all do
    for slide <- Config.slides() do
      struct = struct(__MODULE__, slide)

      %__MODULE__{
        struct
        | title: format_title(slide[:title] || slide.filename),
          notes: slide.notes
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
