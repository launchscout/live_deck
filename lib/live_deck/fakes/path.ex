defmodule LiveDeck.Fakes.Path do
  @moduledoc """
  Mimics the Standard Lib Path module for
  the purposes of testing
  """

  @doc false
  def relative_to_cwd(path) do
    path
  end

  @doc false
  def expand(path, _dir), do: path
end
