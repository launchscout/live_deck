defmodule LiveDeck.Fake.File do
  @moduledoc """
  Mimics the real File module
  """
  @slides ~w(slide_1.html.eex slide_2.html.eex slide_3.html.eex)

  def ls!(_path) do
    @slides
  end
end
