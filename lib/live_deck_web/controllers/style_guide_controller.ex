defmodule LiveDeckWeb.StyleGuideController do
  use LiveDeckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
