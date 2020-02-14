defmodule LiveDeck.Presentations.Presentation do
  @moduledoc """
  Exposes a Presentation struct and functions for
  working with Presentations.
  """
  alias LiveDeck.Presentations.Slide

  @slides Slide.all()
  @enforce_keys [:slides, :last_slide]
  defstruct slides: [],
            last_slide: nil

  @type t() :: %__MODULE__{
          slides: list(String.t()),
          last_slide: non_neg_integer()
        }

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
