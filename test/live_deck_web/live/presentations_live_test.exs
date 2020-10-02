defmodule LiveDeckWeb.PresentationLiveTest do
  use LiveDeckWeb.ConnCase
  import Phoenix.LiveViewTest
  alias LiveDeck.Controls

  describe "ControlLive" do
    setup :mount

    test "renders the control index template", %{html: html} do
      assert html =~ ~s(data-testid=\"PresentationsLiveView\")
    end

    test "subscribes to the controls:channel pubsub topic", %{view: view} do
      initial_view = render(view)

      presentation = Controls.get_presentation()
      reveal_count = presentation.slides |> List.first() |> Map.get(:reveals) |> Map.get(:count)
      ## Loop through all reveals
      for _ <- 1..reveal_count, do: Controls.navigate(:next)
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
