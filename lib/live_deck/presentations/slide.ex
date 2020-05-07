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
  def all do
    for filename <- slides() do
      case Repo.get_by(__MODULE__, filename: filename) do
        nil ->
          %__MODULE__{}
          |> change(%{filename: filename, title: filename_to_title(filename)})
          |> Repo.insert!()

        slide ->
          slide
      end
    end
  end

  defp filename_to_title(filename) do
    filename
    |> String.replace(".html", "")
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(fn word -> String.capitalize(word) end)
    |> Enum.join(" ")
  end

  defp slides do
    for slide <- @slides_dir |> File.ls!() do
      String.replace(slide, ".eex", "")
    end
  end
end
