defmodule LiveDeck.Presentations.Presentation do
  @moduledoc """
  Exposes a Presentation struct and functions for
  working with Presentations.
  """
  alias LiveDeck.Presentations.Slide

  @enforce_keys [:active_index]
  defstruct slides: [],
            active_index: 0,
            last_index: nil

  @type t() :: %__MODULE__{
          slides: list(Slide.title()),
          active_index: non_neg_integer(),
          last_index: non_neg_integer()
        }

  @doc """
  Moves to the next piece of content for the Presentation.
  """
  @spec next_content(t()) :: t()
  def next_content(%__MODULE__{active_index: active, last_index: last} = presentation)
      when active == last,
      do: presentation

  def next_content(%__MODULE__{active_index: index} = presentation) do
    %__MODULE__{presentation | active_index: index + 1}
  end

  @doc """
  Moves to the previous slide of the Presentation.
  """
  @spec prev_slide(t()) :: t()
  def prev_slide(%__MODULE__{active_index: 0} = presentation), do: presentation

  def prev_slide(%__MODULE__{active_index: index} = presentation) do
    %__MODULE__{presentation | active_index: index - 1}
  end

  @doc """
  Returns the slide title at the given index.
  """
  @spec slide(t(), [{:at_index, pos_integer()}]) :: Slide.t()
  def slide(%__MODULE__{slides: slides}, at_index: index) do
    Enum.at(slides, index)
  end

  @doc """
  Instantiates a new Presentation.
  """
  @spec new() :: t()
  def new do
    slides = Slide.all()

    %__MODULE__{
      slides: slides,
      active_index: 0,
      last_index: length(slides) - 1
    }
  end

  @doc """
  Returns title of slide at the Presentation's active index
  """
  @spec current_slide(t()) :: Slide.t()
  def current_slide(%__MODULE__{active_index: index, slides: slides}),
    do: Enum.at(slides, index)
end
