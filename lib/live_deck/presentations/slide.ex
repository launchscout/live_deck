defmodule LiveDeck.Presentations.Slide do
  @moduledoc """
  This module exposes functions for working
  with Slides.
  """
  use Ecto.Schema
  alias LiveDeck.Repo
  import Ecto.Changeset

  schema "slides" do
    field :filename, :string
    field :background_color, :string
    field :title, :string
  end

  @type title :: String.t()

  @slides_dir "../../live_deck_web/templates/slide/" |> Path.expand(__DIR__)
  @slides (for slide <- @slides_dir |> File.ls!() do
             @external_resource Path.relative_to_cwd(@slides_dir <> slide)
             String.replace(slide, ".eex", "")
           end)

  def all do
    for filename <- @slides do
      case Repo.get_by(__MODULE__, filename: filename) do
        nil ->
          %__MODULE__{}
          |> change(%{filename: filename, title: filename})
          |> Repo.insert!()

        slide ->
          slide
      end
    end
  end
end
