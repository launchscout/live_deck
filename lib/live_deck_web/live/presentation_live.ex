defmodule LiveDeckWeb.PresentationLive do
  @moduledoc """
  Live view for presentation
  """
  use Phoenix.LiveView
  alias LiveDeck.Presentations

  def mount(_params, _session, socket) do
    {:ok, assign(socket, presentation: @presentation, current: Presentations.current_slide())}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.PresentationView, "index.html", assigns)
  end
end
