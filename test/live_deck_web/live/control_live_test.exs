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

    test "renders the notes button if the slide has notes", %{html: html} do
      assert html =~ ~s(data-testid="notes-button")
    end

    test "does not render the notes button if the slide has no notes", %{view: view} do
      refute render_click(view, "next") =~ ~s(data-testid="notes-button")
    end
  end

  describe "notes modal" do
    setup :mount
    @toggle_notes "toggle_notes"
    @notes_modal ~s(data-testid="NotesModal")

    test "does not get shown on mount", %{html: html} do
      refute html =~ @notes_modal
    end

    test "renders when a user clicks the notes button", %{view: view} do
      html = render_click(view, @toggle_notes)
      assert html =~ @notes_modal
    end

    test "closes when modal is open and a user hits the close button", %{view: view} do
      render_click(view, @toggle_notes)
      html = render_click(view, @toggle_notes)
      refute html =~ @notes_modal
    end
  end

  describe "master drawer" do
    setup :mount
    @toggle_drawer "toggle_drawer"
    @master_drawer ~s(data-testid="MasterDrawer")

    test "does not get shown on mount", %{html: html} do
      refute html =~ @master_drawer
    end

    test "renders when a user toggles the master drawer", %{view: view} do
      html = render_click(view, @toggle_drawer)
      assert html =~ @master_drawer
    end

    test "renders iframes for each slide in the presentation", %{view: view} do
      html = render_click(view, @toggle_drawer)
      assert html =~ ~s(<iframe id="slide-0">)
    end

    test "renders an iframe with src pointing to thumbnails + slide index path", %{view: view} do
      html = render_click(view, @toggle_drawer)

      assert html =~
               ~s(<iframe id="slide-0" src="#{LiveDeckWeb.Endpoint.thumbnail_url(:show, 1)}">)
    end
  end

  defp mount(context) do
    {:ok, view, html} = live(context.conn, "/remote")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end
end
