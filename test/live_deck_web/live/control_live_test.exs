defmodule LiveDeckWeb.ControlLiveTest do
  use LiveDeckWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "ControlLive" do
    setup :mount

    test "renders the control index template", %{html: html} do
      assert html =~ ~s(data-testid=\"remote-page\")
    end

    test "renders the current slide index", %{html: html} do
      assert html =~ ~s(data-current-slide=\"1\")
    end

    test "clicking the next button increment the current slide", %{view: view} do
      assert render_click(view, "next") =~ ~s(data-current-slide=\"2\")
    end

    test "clicking the prev button decrements the current slide", %{view: view} do
      render_click(view, "next")
      assert render_click(view, "prev") =~ ~s(data-current-slide=\"1\")
    end
  end

  defp mount(context) do
    {:ok, view, html} = live(context.conn, "/remote")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end
end
