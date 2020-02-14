defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """
  @path Application.get_env(:live_deck, :path_module) || Path
  @slides (for slide <- "lib/live_deck_web/templates/slide/*.html.*eex" |> @path.wildcard() do
             @external_resource @path.relative_to_cwd(slide)
             slide
           end)

  @type title :: String.t()

  def all do
    @slides
  end
end
