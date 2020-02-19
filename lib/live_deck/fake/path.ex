defmodule LiveDeck.Fake.Path do
  @moduledoc """
  Mimics the real Path module from the
  standard library.
  """

  @doc false
  def expand(path, _dir), do: path

  @doc false
  def relative_to_cwd(_path), do: ""
end
