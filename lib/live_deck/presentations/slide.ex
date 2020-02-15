defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """
  @type title :: String.t()
  @slides_dir "../../live_deck_web/templates/slide/" |> Path.expand(__DIR__)

  def all do
    for slide <- File.ls!(@slides_dir) do
      String.replace(slide, ".eex", "")
    end
  end
end
