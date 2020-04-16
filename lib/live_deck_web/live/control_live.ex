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

    socket =
      Controls.get_presentation()
      |> assign_presentation(socket)
      |> assign_timer(Timer.init())
      |> assign(:timer_start_class, "")

    {:ok, socket}
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
    {:noreply, assign_timer(socket, Timer.start())}
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

  def handle_info(:tick, socket) do
    time = Time.add(socket.assigns.time, 1)
    {:noreply, assign(socket, time: time, formatted_time: time |> to_mm_ss)}
  end

  defp assign_presentation(presentation, socket) do
    socket
    |> assign(presentation: presentation)
    |> assign(current_slide: presentation.active_index + 1)
  end

  defp assign_timer(socket, timer) do
    socket
    |> assign(timer: timer)
  end

  defp to_mm_ss(time) do
    elapsed = Time.diff(time, ~T[00:00:00.00])

    mm = div(elapsed, 60)
    ss = rem(elapsed, 60) |> format_digit

    "#{mm}:#{ss}"
  end

  defp format_digit(unit) do
    case unit < 10 do
      true -> "0#{unit}"
      false -> "#{unit}"
    end
  end
end
