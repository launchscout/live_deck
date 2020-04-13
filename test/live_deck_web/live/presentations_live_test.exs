defmodule LiveDeckWeb.PresentationLiveTest do
  use LiveDeckWeb.ConnCase
  import Phoenix.LiveViewTest
  alias LiveDeck.Controls

  describe "ControlLive" do
    setup :mount

    test "renders the control index template", %{html: html} do
      assert html =~ ~s(data-testid=\"PresentationsLiveView\")
    end

<<<<<<< HEAD
    test "subscribes to the controls:channel pubsub topic", %{view: view} do
=======
    test "subscribes to the controls:channel pubsub topic", %{html: html, view: view} do
>>>>>>> Hook into navigation events on PresentationsLive
      initial_view = render(view)
      ## Publishes an event to the controls:channel that updates the slide
      Controls.navigate(:next)
      refute render(view) == initial_view
    end
  end

  defp mount(context) do
    Controls.start()
    {:ok, view, html} = live(context.conn, "/")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end
end
