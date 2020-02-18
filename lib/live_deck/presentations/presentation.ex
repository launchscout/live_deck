defmodule LiveDeck.Presentations.Presentation do
  @moduledoc """
  Exposes a Presentation struct and functions for
  working with Presentations.
  """
  alias LiveDeck.Presentations.Slide
  alias LiveDeck.Presentations.Presentation.CurrentSlide

  @slides Slide.all()
  @enforce_keys [:slides, :last_slide]
  defstruct slides: [],
            last_slide: nil

  @type t() :: %__MODULE__{
          slides: list(String.t()),
          last_slide: non_neg_integer()
        }

  @doc """
  Returns current slide of Presentation.
  """
  @spec current_slide() :: non_neg_integer()
  def current_slide do
    CurrentSlide.get_current()
  end

  @doc """
  Increments the current slide of Presentation.
  """
  @spec current_slide() :: non_neg_integer()
  def increment_slide do
    CurrentSlide.increment_current()
  end

  @doc """
  Instantiates a new Presentation.
  """
  @spec new() :: t()
  def new do
    %__MODULE__{
      slides: @slides,
      last_slide: length(@slides) - 1
    }
  end
end
