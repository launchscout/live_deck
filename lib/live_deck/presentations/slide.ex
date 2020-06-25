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
    :reveals,
    :position,
    :notes
  ]

  @type reveal ::
          pos_integer()
          | %{
              required(:count) => pos_integer(),
              optional(:starting_with) => :empty | :revealed,
              optional(:operation) => :append | :prepend | :replace
            }
  @type t :: %__MODULE__{
          filename: String.t(),
          background_color: String.t(),
          title: String.t(),
          reveals: list(reveal),
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
          reveals: slide[:reveals],
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
