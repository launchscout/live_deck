defmodule LiveDeck.PresentationsTest do
  alias LiveDeck.Presentations
  use ExUnit.Case

  @temp_slides ~w(slide_1.html.eex slide_2.html.eex slide_3.html.eex)

  describe "list_slides/0" do
    setup :create_temp_slides

    test "returns a list of all slides" do
      for slide <- Presentations.list_slides() do
        assert String.ends_with?(slide, ".html")
      end
    end
  end

  describe "current_slide/0" do
    setup :create_temp_slides

    # test "returns the current slide" do
    #   assert Presentations.current_slide() == "slide_1.html"
    # end
  end

  defp create_temp_slides(_) do
    path = Path.expand("../lib/live_deck_web/templates/slide/", __DIR__)

    for slide <- @temp_slides do
      File.write("#{path}#{slide}", "<div>This is slide: #{slide}</div>")
    end

    on_exit(fn ->
      for slide <- @temp_slides do
        File.rm_rf("#{path}#{slide}")
      end
    end)
  end
end
