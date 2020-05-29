defmodule LiveDeckWeb.ControlLive do
  @moduledoc """
    Live view for control route
  """
  use Phoenix.LiveView
  alias LiveDeck.Controls
  alias LiveDeck.Controls.Timer
  require Logger
  @valid_actions ~w(next prev)

  defmodule ViewControls do
    @moduledoc """
    Exposes a struct with attributes used to
    control visual components in templates.
    """
    defstruct timer_start_class: "",
              show_notes?: false,
              master_drawer: :closed

    @type t() :: %__MODULE__{
            timer_start_class: String.t(),
            show_notes?: boolean(),
            master_drawer: :closed | :open
          }
  end

  def mount(_params, _session, socket) do
    Controls.start()

    socket =
      Controls.get_presentation()
      |> assign_presentation(socket)
      |> assign_timer(Timer.init())
      |> assign(:view_controls, %ViewControls{})

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
    case assigns.view_controls.timer_start_class do
      "" ->
        {:noreply,
         socket
         |> assign_view_controls(timer_start_class: "timer__start")
         |> assign_timer(Timer.stop(timer))}

      "timer__start" ->
        {:noreply,
         socket
         |> assign_view_controls(timer_start_class: "")
         |> assign_timer(Timer.stop(timer))}
    end
  end

  def handle_event("toggle_notes", _, socket) do
    {:noreply,
     assign_view_controls(socket, show_notes?: !socket.assigns.view_controls.show_notes?)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign_timer(socket, Timer.tick(socket.assigns.timer))}
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

  defp assign_view_controls(socket, updates) do
    socket
    |> assign(view_controls: struct(socket.assigns.view_controls, updates))
  end
end
