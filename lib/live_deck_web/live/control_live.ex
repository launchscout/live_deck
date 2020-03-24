defmodule LiveDeckWeb.ControlLive do
  @moduledoc """
    Live view for control route
  """
  use Phoenix.LiveView
  alias LiveDeck.Controls
  require Logger

  def mount(_params, _session, socket) do
    Controls.start()
    presentation = Controls.get_presentation()
    socket =
      socket
      |> assign(presentation: presentation)
      |> assign(current_slide: presentation.active_index + 1)
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.ControlView, "index.html", assigns)
  end

  def handle_event("inc", _, socket) do
    {:noreply, socket}
  end
end
