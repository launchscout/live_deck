defmodule LiveDeckWeb.ControlView do
  use Phoenix.LiveView
  alias LiveDeck.Presentations
  require Logger
  @slides Presentations.list_slides()

  def mount(_params, _session, socket) do
    {:ok, assign(socket, [current: 0, slides: @slides])}
  end

  def render(assigns) do
    ~L"""
      <button phx-click="prev">Previous!</button>
      <button phx-click="next">Next!</button>
    """
  end

  def handle_event("next", _, socket) do
    {:noreply, assign(socket, [current: socket.assigns[:current] + 1, slides: @slides])}
  end

  def handle_event("prev", _, socket) do
    {:noreply, assign(socket, [current: socket.assigns[:current] - 1, slides: @slides])}
  end
end
