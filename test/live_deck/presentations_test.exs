defmodule LiveDeck.PresentationsTest do
  alias LiveDeck.Presentations
  alias LiveDeck.Presentations.Presentation
  use ExUnit.Case

  describe "load/0" do
    test "bootstraps a presentation struct" do
      presentation = Presentations.load()
      for slide <- presentation.slides do
        assert String.ends_with?(slide, ".html")
      end
    end
  end

  describe "next_slide/1" do
    test "updates active index if there is a next slide" do
      assert %Presentation{active_index: 1} = Presentation.new() |> Presentation.next_slide()
    end

    test "is a no-op when the active index is the last index" do
      presentation = %Presentation{
        slides: Presentations.load().slides,
        active_index: 3,
        last_index: 3
      }

      assert presentation == Presentation.next_slide(presentation)
    end
  end

  describe "current_slide/1" do
    test "returns title of slide at active index" do
      presentation = Presentation.new()
      assert presentation |> Presentation.current_slide() == List.first(presentation.slides)
    end
  end
end
