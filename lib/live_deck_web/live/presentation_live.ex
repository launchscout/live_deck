defmodule LiveDeckWeb.PresentationLive do
  @moduledoc """
  Live view for presentation
  """
  use Phoenix.LiveView
  alias LiveDeck.Presentations
  require Logger
  @slides Presentations.list_slides()

  def mount(_params, _session, socket) do
    {:ok, assign(socket, current: 0, slides: @slides)}
  end

  def render(assigns) do
    Logger.info(inspect(assigns[:current]))

    ~L"""
      <p><%= Phoenix.View.render LiveDeckWeb.View.PresentationView, Enum.at(@slides, assigns[:current]), assigns %></p>
    """
  end
end
