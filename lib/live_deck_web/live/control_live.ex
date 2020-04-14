defmodule LiveDeckWeb.ControlLive do
  @moduledoc """
    Live view for control route
  """
  use Phoenix.LiveView
  alias LiveDeck.Controls
  require Logger
  @valid_actions ~w(next prev)

  def mount(_params, _session, socket) do
    Controls.start()
    {:ok, assign_presentation(Controls.get_presentation(), socket)}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.ControlView, "index.html", assigns)
  end

  def handle_event(action, _, socket) when action in @valid_actions do
    {:noreply,
     action
     |> String.to_existing_atom()
     |> Controls.navigate()
     |> assign_presentation(socket)}
  end

  def handle_event("start_timer", _, socket) do
    {:noreply, assign(socket, :presentation, nil)}
  end

  defp assign_presentation(presentation, socket) do
    socket
    |> assign(presentation: presentation)
    |> assign(current_slide: presentation.active_index + 1)
  end
end
