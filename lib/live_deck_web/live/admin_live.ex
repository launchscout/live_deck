defmodule LiveDeckWeb.AdminLive do
  @moduledoc """
  Live view for the admin screen
  """
  use Phoenix.LiveView
  alias LiveDeck.Presentations
  alias LiveDeckWeb.AdminView

  def mount(_params, _session, socket) do
    presentation = Presentations.load()

    {:ok, assign(socket, presentation: presentation)}
  end

  def render(assigns) do
    AdminView.render("index.html", assigns)
  end
end
