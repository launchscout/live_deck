defmodule LiveDeck.Fakes.File do
  @moduledoc false

  @files ~w(slide_1.html.eex slide_2.html.eex slide_3.html.eex slide_4.html.eex)

  def ls!(_path) do
    @files
  end
end
