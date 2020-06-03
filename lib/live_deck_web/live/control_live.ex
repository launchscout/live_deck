defmodule LiveDeckWeb.ControlLive do
  @moduledoc """
    Live view for control route
  """
  use Phoenix.LiveView
  alias LiveDeck.Controls
  alias LiveDeck.Controls.Timer
  require Logger
  @valid_actions ~w(next prev)

  def mount(_params, _session, socket) do
    Controls.start()

    if connected?(socket) do
      Controls.subscribe()
    end

    socket =
      Controls.get_presentation()
      |> assign_presentation(socket)
      |> assign_timer(Timer.init())
      |> assign(:timer_start_class, "")
      |> assign(:show_notes?, false)
      |> assign(:menu_class, "")
      |> assign(:menu_drawer, "")

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.ControlView, "index.html", assigns)
  end

  def handle_event("toggle_menu", _, socket) do
    case socket.assigns.menu_class do
      "" -> {:noreply, assign(socket, menu_class: "hamburger--close", menu_drawer: "menu--open")}
      "hamburger--close" -> {:noreply, assign(socket, menu_class: "", menu_drawer: "menu--close")}
    end
  end

  def handle_event(action, _, socket) when action in @valid_actions do
    {:noreply,
     action
     |> String.to_existing_atom()
     |> Controls.navigate()
     |> assign_presentation(socket)}
  end

  def handle_event("start_timer", _, socket) do
    {:noreply, assign_timer(socket, Timer.start())}
  end

  def handle_event("set_slide_index", %{"index" => index}, socket) do
    Controls.set_current_slide(String.to_integer(index))
    {:noreply, socket}
  end

  def handle_event("stop_timer", _, %{assigns: %{timer: timer} = assigns} = socket) do
    case assigns.timer_start_class do
      "" ->
        {:noreply,
         socket
         |> assign(timer_start_class: "timer__start")
         |> assign_timer(Timer.stop(timer))}

      "timer__start" ->
        {:noreply, socket |> assign(timer_start_class: "") |> assign_timer(Timer.stop(timer))}
    end
  end

  def handle_event("toggle_notes", _, socket) do
    {:noreply, assign(socket, :show_notes?, !socket.assigns.show_notes?)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign_timer(socket, Timer.tick(socket.assigns.timer))}
  end

  def handle_info(%{event: "presentation_update", payload: presentation}, socket) do
    {:noreply, assign_presentation(presentation, socket)}
  end

  defp assign_presentation(presentation, socket) do
    socket
    |> assign(presentation: presentation)
    |> assign(current_slide_index: presentation.active_index + 1)
    |> assign(current_slide: LiveDeck.Presentations.current_slide(presentation))
  end

  defp assign_timer(socket, timer) do
    socket
    |> assign(timer: timer)
  end
end
