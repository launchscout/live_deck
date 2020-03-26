defmodule LiveDeckWeb.ControlLiveTest do
  use LiveDeckWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "ControlLive" do
    setup :mount

    test "renders the control index template", %{html: html} do
      assert html =~ "data-testid=\"control-page\""
    end

    test "renders the current slide index", %{html: html} do
      assert html =~ "data-current-slide=\"1\""
    end
  end

  defp mount(context) do
    {:ok, view, html} = live(context.conn, "/controls")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end
end
