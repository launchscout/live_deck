defmodule LiveDeckWeb.PresentationLive do
  @moduledoc """
  Live view for presentation
  """
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, background: "back--1")}
  end

  def render(assigns) do
    Phoenix.View.render(LiveDeckWeb.PresentationView, "index.html", assigns)
  end
end
