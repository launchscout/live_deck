defmodule LiveDeckWeb.PageController do
  use LiveDeckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
