defmodule LiveDeck.Presentations.Presentation do
  @moduledoc """
  Exposes a Presentation struct and functions for
  working with Presentations.
  """
  alias LiveDeck.Presentations.Slide
  alias LiveDeck.Presentations.Presentation.CurrentSlide

  @slides Slide.all()
  @enforce_keys [:slides, :active_index, :last_slide]
  defstruct slides: [],
            active_index: 0,
            last_slide: nil

  @type t() :: %__MODULE__{
          slides: list(Slide.title()),
          active_index: non_neg_integer(),
          last_slide: non_neg_integer()
        }

  @doc """
  Moves to the next slide of the Presentation.
  """
  @spec next_slide(t()) :: t()
  def next_slide(%__MODULE__{slides: slides, active_index: index} = presentation) do
    %__MODULE__{presentation |
      active_index: index + 1
    }
  end

  @doc """
  Instantiates a new Presentation.
  """
  @spec new() :: t()
  def new do
    %__MODULE__{
      slides: @slides,
      active_index: 0,
      last_slide: length(@slides) - 1
    }
  end
end
