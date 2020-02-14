defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """
  @path Application.get_env(:live_deck, :path_module) || Path
  @file_mod Application.get_env(:live_deck, :file_module) || File
  @slides_dir "../../live_deck_web/templates/slide/" |> @path.expand(__DIR__)
  @slides (for slide <- @slides_dir |> @file_mod.ls!() do
             @external_resource @path.relative_to_cwd(@slides_dir <> slide)
             String.replace(slide, ".eex", "")
           end)

  @type title :: String.t()

  def all do
    @slides
  end
end
