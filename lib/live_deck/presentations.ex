defmodule LiveDeck.Presentations do
  @moduledoc """
  Exposes an API for working with and
  manipulating presentations.
  """
  alias LiveDeck.Presentations.{Presentation, Slide}
  require Logger

  @presentations_topic "presentations:lobby"

  @type presentation :: Presentation.t()

  @doc """
  Bootstraps a presentation struct by loading
  available slides from the lib/live_deck_web/templates/slide
  directory.
  """
  @spec load() :: Presentation.t()
  def load(), do: Presentation.new()

  @doc """
  Subscribes to the presentations:lobby pubsub topic
  """
  @spec subscribe() :: :ok | no_return()
  def subscribe(), do: LiveDeckWeb.Endpoint.subscribe(@presentations_topic)

  @doc """
  Returns the title of the current slide
  """
  @spec current_slide(Presentation.t()) :: Slide.t()
  def current_slide(presentation) do
    Presentation.current_slide(presentation)
  end

  @doc """
  Returns the slide title at the given index.
  """
  @spec slide(Presentation.t(), [{:at_index, pos_integer()}]) :: Slide.t()
  def slide(presentation, at_index: index) do
    Presentation.slide(presentation, at_index: index)
  end

  @doc """
  Sets the active index of the presentation to the given index
  """
  @spec set_current_slide(Presentation.t(), non_neg_integer()) :: Presentation.t()
  def set_current_slide(presentation, index) do
    %Presentation{presentation | active_index: index}
  end

  @doc """
  Navigates to the next slide
  """
  @spec next_slide(Presentation.t()) :: Presentation.t()
  def next_slide(presentation) do
    Presentation.next_slide(presentation)
  end

  @doc """
  Navigates to the previous slide
  """
  @spec prev_slide(Presentation.t()) :: Presentation.t()
  def prev_slide(presentation) do
    Presentation.prev_slide(presentation)
  end
end
