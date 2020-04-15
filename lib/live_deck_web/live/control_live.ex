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

    {:ok,
     assign_presentation(Controls.get_presentation(), socket)
     |> init_timer()}
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
    {:ok, timer} = :timer.send_interval(1000, :tick)
    time = ~T[00:00:00.00]

    {:noreply,
     assign(
       socket,
       timer: timer,
       time: time,
       formatted_time: time |> to_mm_ss
     )}
  end

  def handle_event("stop_timer", _, socket) do
    {:noreply, socket |> reset_timer}
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

  defp init_timer(socket) do
    socket
    |> assign(time: nil)
    |> assign(timer: nil)
    |> assign(formatted_time: nil)
  end

  defp reset_timer(socket) do
    :timer.cancel(socket.assigns.timer)

    socket
    |> init_timer
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
