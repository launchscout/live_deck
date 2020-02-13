defmodule LiveDeck.Presentations do
  @moduledoc """
  Exposes an API for working with and
  manipulating presentations.
  """
  alias LiveDeck.Presentations.Slide

  @doc """
  Returns a list of all available slides by
  title (the path to the file)
  """
  @spec list_slides() :: list(Slide.title())
  def list_slides do
    Slide.all()
  end
end
