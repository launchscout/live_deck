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
  @spec current_slide() :: Slide.title()
  def current_slide do
    Logger.info("slides, #{inspect(Slide.all())}, current: #{Presentation.current_slide()}")
    Enum.at(Slide.all(), Presentation.current_slide())
  end

  @doc """
  Increments current slide forward
  """
  def increment_slide do
    Presentation.increment_slide()
  end
end
