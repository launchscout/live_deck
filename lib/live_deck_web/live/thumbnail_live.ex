defmodule LiveDeckWeb.ThumbnailLive do
  use Phoenix.LiveView

  alias LiveDeck.Controls
  alias LiveDeck.Presentations

  def mount(%{"id" => id}, _session, socket) do
    Controls.start()
    presentation = Controls.get_presentation()
    slide = Presentations.slide(presentation, at_index: String.to_integer(id))

    {:ok, assign(socket, :slide, slide)}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.ThumbnailView, "show.html", assigns)
  end
end
