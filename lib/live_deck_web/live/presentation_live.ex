defmodule LiveDeckWeb.PresentationLive do
  @moduledoc """
  Live view for presentation
  """
  use Phoenix.LiveView
  alias LiveDeck.Presentations
  @presentation Presentations.load()

  def mount(_params, _session, socket) do
    {:ok, assign(socket, current: Presentations.current_slide(@presentation))}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.PresentationView, "index.html", assigns)
  end
end
