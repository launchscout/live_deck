defmodule LiveDeckWeb.AdminLive do
  @moduledoc """
  Live view for the admin screen
  """
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, stuff: "value")}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.AdminView, "index.html", assigns)
  end
end
