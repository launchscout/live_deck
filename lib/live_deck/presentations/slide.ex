defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """
  @type title :: String.t()
  @slides_dir "../../live_deck_web/templates/slide" |> Path.expand(__DIR__)

  def all do
    case File.ls(@slides_dir) do
      {:error, _} ->
        File.mkdir_p(@slides_dir)
        []

      {:ok, slides} ->
        for slide <- slides do
          String.replace(slide, ".eex", "")
        end
    end
  end
end
