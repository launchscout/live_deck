defmodule LiveDeck.Fakes.Path do
  @moduledoc """
  Mimics the Standard Lib Path module for
  the purposes of testing
  """
  @fake_slides ~w(slide_1 slide_2 slide_3 slide_4)

  @doc false
  def relative_to_cwd(path) do
    path
  end

  @doc false
  def wildcard(_arg) do
    @fake_slides
  end
end
