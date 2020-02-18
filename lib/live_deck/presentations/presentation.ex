defmodule LiveDeck.Presentations.Presentation do
  @moduledoc """
  Exposes a Presentation struct and functions for
  working with Presentations.
  """
  alias LiveDeck.Presentations.Slide
  alias LiveDeck.Presentations.Presentation.CurrentSlide

  @slides Slide.all()
  @enforce_keys [:slides, :active_index, :last_index]
  defstruct slides: [],
            active_index: 0,
            last_index: nil

  @type t() :: %__MODULE__{
          slides: list(Slide.title()),
          active_index: non_neg_integer(),
          last_index: non_neg_integer()
        }

  @doc """
  Moves to the next slide of the Presentation.
  """
  @spec next_slide(t()) :: t()
  def next_slide(%__MODULE__{active_index: active, last_index: last} = presentation)
      when active == last,
      do: presentation

  def next_slide(%__MODULE__{slides: slides, active_index: index} = presentation) do
    %__MODULE__{presentation | active_index: index + 1}
  end

  @doc """
  Instantiates a new Presentation.
  """
  @spec new() :: t()
  def new do
    %__MODULE__{
      slides: @slides,
      active_index: 0,
      last_index: length(@slides) - 1
    }
  end

  @doc """
  Returns title of slide at the Presentation's active index
  """
  @spec current_slide(t()) :: Slide.title()
  def current_slide(%__MODULE__{active_index: index, slides: slides}), do: Enum.at(slides, index)
end
