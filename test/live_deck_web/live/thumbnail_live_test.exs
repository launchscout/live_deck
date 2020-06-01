defmodule LiveDeckWeb.ThumbnailControllerTest do
  use LiveDeckWeb.ConnCase
  import Phoenix.LiveViewTest

  alias LiveDeck.Presentations

  setup context do
    LiveDeck.Controls.start()

    {:ok, context}
  end

  describe "show" do
    setup :mount

    test "renders the slide at position :id", %{html: html} do
      expected_slide = Presentations.slide(LiveDeck.Controls.get_presentation(), at_index: 0)
      assert html =~ ~s(data-testid=\"thumbnail-#{expected_slide.title}\")
    end
  end

  defp mount(context) do
    {:ok, view, html} = live(context.conn, "/thumbnails/0")
    {:ok, Map.merge(context, %{view: view, html: html})}
  end
end
