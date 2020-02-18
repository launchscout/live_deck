defmodule LiveDeck.Presentations do
  @moduledoc """
  Exposes an API for working with and
  manipulating presentations.
  """
  alias LiveDeck.Presentations.Slide
  alias LiveDeck.Presentations.Presentation
  require Logger

  @doc """
  Returns a list of all available slides by
  title (the path to the file)
  """
  @spec list_slides() :: list(Slide.title())
  def list_slides do
    Slide.all()
  end

  @doc """
  Returns the title of the current slide
  """
  @spec current_slide(Presentation.t()) :: Slide.title()
  def current_slide(presentation) do
    Presentation.current_slide(presentation)
  end

  @doc """
  Navigates to the next slide
  """
  @spec next_slide(Presentation.t()) :: Presentation.t()
  def next_slide(presentation) do
    Presentation.next_slide(presentation)
  end
end
