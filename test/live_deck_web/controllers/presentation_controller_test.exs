defmodule LiveDeckWeb.PresentationControllerTest do
  use LiveDeckWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end
end
