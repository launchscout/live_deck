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

    test "shows the next slide title unless the current slide is the last slide", %{html: html} do
      presentation = LiveDeck.Controls.get_presentation()
      second_slide = LiveDeck.Presentations.slide(presentation, at_index: 1)

      assert html =~ ~s(Next: #{second_slide.title})
    end

    test "does not show the next slide title when the current slide is the last slide", %{
      view: view
    } do
      presentation = LiveDeck.Controls.get_presentation()
      LiveDeck.Controls.set_current_slide(presentation.last_index)

      refute render(view) =~ ~s(Next: )
    end

    # check for desktop view
    test "renders the active slide preview in desktop view", %{html: html} do
      assert html =~ ~s(data-testid="active-slide-preview")
    end

    test "renders the next slide preview in desktop view if existent", %{view: view} do
      presentation = LiveDeck.Controls.get_presentation()
      LiveDeck.Controls.set_current_slide(presentation.last_index)

      refute render(view) =~ ~s(data-testid="next-slide-preview")
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

  describe "thumbnail drawer" do
    setup [:mount, :open_thumbnail_drawer]

    test "renders thumbnails for each slide in the presentation", %{html: html} do
      presentation = LiveDeck.Controls.get_presentation()

      for slide_index <- 0..presentation.last_index do
        assert html =~ "<iframe src=\"/thumbnails/#{slide_index}\">"
      end
    end

    test "updates the presentation slide to the slide at the index clicked on", %{view: view} do
      view |> element(~s([data-testid="thumbnail-4"])) |> render_click()
      assert LiveDeck.Controls.get_presentation().active_index == 4
    end

    test "clicking on a slide closes the thumbnail drawer and updates the remote with the new slide",
         %{view: view} do
      presentation = LiveDeck.Controls.get_presentation()
      view |> element(~s([data-testid="thumbnail-4"])) |> render_click()
      refute render(view) =~ "menu--open"
      assert render(view) =~ ~s(#{LiveDeck.Presentations.slide(presentation, at_index: 4).title})

      assert render(view) =~
               ~s(Next: #{LiveDeck.Presentations.slide(presentation, at_index: 5).title})
    end
  end

  defp mount(context) do
    {:ok, view, html} = live(context.conn, "/remote")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end

  @toggle_menu "toggle_menu"

  defp open_thumbnail_drawer(context) do
    render_click(context.view, @toggle_menu)
    context
  end
end
