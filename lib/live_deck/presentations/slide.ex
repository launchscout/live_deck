defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """
  @slides_dir "../../live_deck_web/templates/slide/" |> Path.expand(__DIR__)
  @slides (
  case File.ls(@slides_dir) do
    {:ok, slides} -> slides
    {:error, :enoent} ->
      File.mkdir_p(@slides_dir)
      for slide <- @slides_dir |> File.ls!() do
              @external_resource Path.relative_to_cwd(@slides_dir <> slide)
              String.replace(slide, ".eex", "")
      end
  end)

  @type title :: String.t()

  def all do
    @slides
  end
end
