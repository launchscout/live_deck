defmodule LiveDeckWeb.AdminLiveTest do
  use LiveDeckWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "AdminLive" do
    test "renders", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/admin")

      assert html =~ ~s(data-testid="AdminLiveView")
    end
  end
end
