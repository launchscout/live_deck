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

    test "clicking the start timer button toggles the timer", %{view: view} do
      assert render_click(view, "start_timer") =~ ~s(0:00)
    end

    test "clicking the timer toggles back to the start timer button", %{view: view} do
      render_click(view, "start_timer")
      assert render_click(view, "stop_timer") =~ ~s(Start Timer)
    end

    test "clicking the next button while the timer is running resets the timer", %{view: view} do
      render_click(view, "start_timer")
      assert render_click(view, "next") =~ ~s(Start Timer)
    end

    test "clicking the prev button while the timer is running resets the timer", %{view: view} do
      render_click(view, "next")
      render_click(view, "start_timer")
      assert render_click(view, "prev") =~ ~s(Start Timer)
    end
  end

  defp mount(context) do
    {:ok, view, html} = live(context.conn, "/remote")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end
end
