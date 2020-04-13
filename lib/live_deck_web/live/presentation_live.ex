defmodule LiveDeckWeb.PresentationLive do
  @moduledoc """
  Live view for presentation
  """
  use Phoenix.LiveView
  alias LiveDeck.Controls

  def mount(_params, _session, socket) do
    Controls.start()

    if connected?(socket) do
      Controls.subscribe()
    end

    {:ok, assign(socket, background: "back--1", presentation: Controls.get_presentation())}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.PresentationView, "index.html", assigns)
  end

  def handle_info(%{event: "presentation_update", payload: presentation}, socket) do
    {:noreply, assign(socket, presentation: presentation)}
  end
end
