defmodule LiveDeckWeb.StyleGuideController do
  use LiveDeckWeb, :controller

  def index(conn, _params) do
    live_render(conn, LiveDeckWeb.PresentationLive, session: %{})
  end
end
