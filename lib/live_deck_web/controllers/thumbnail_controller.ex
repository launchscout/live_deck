defmodule LiveDeckWeb.ThumbnailController do
  use LiveDeckWeb, :controller

  alias LiveDeck.Presentation
  alias LiveDeck.Presentation.Thumbnail

  def show(conn, %{"id" => id}) do
    thumbnail = Presentation.get_thumbnail!(id)
    render(conn, "show.html", thumbnail: thumbnail)
  end
end
