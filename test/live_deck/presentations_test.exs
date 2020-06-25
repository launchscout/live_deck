defmodule LiveDeck.PresentationsTest do
  alias LiveDeck.Presentations
  alias LiveDeck.Presentations.{Presentation, Slide}
  use ExUnit.Case, async: false

  describe "load/0" do
    setup :load_presentation

    test "bootstraps a presentation struct", %{presentation: presentation} do
      for %Slide{filename: filename} <- presentation.slides do
        assert String.ends_with?(filename, ".html")
      end
    end

    test "strips .html and underscores out of the filename to create the title", %{
      presentation: presentation
    } do
      for slide <- presentation.slides do
        refute String.ends_with?(slide.title, ".html")
        refute String.contains?(slide.title, "_")
      end
    end

    test "capitalizes the words in the title", %{presentation: presentation} do
      slide = List.first(presentation.slides)

      Enum.each(String.split(slide.title), fn <<first_letter, _rest::binary>> ->
        assert Regex.match?(~r/([A-Z]|\d)/, <<first_letter>>)
      end)
    end

    test "inserts notes on slides", %{presentation: presentation} do
      assert Enum.all?(presentation.slides, fn slide -> slide.notes end)
    end
  end

  describe "next_content/1" do
    test "updates active index if there is a next slide" do
      assert %Presentation{active_index: 1} = Presentations.load() |> Presentations.next_content()
    end

    test "is a no-op when the active index is the last index" do
      presentation = %Presentation{
        slides: Presentations.load().slides,
        active_index: 3,
        last_index: 3
      }

      assert presentation == Presentations.next_content(presentation)
    end
  end

  describe "prev_content/1" do
    test "updates active index if there is a previous slide" do
      assert %Presentation{active_index: 0} =
               Presentations.prev_content(%Presentation{active_index: 1})
    end

    test "is a no-op when the active index is 0" do
      presentation = %Presentation{
        slides: Presentations.load().slides,
        active_index: 0,
        last_index: 3
      }

      assert presentation == Presentations.prev_content(presentation)
    end
  end

  describe "current_slide/1" do
    test "returns the slide at the active index" do
      presentation = Presentations.load()

      assert presentation |> Presentations.current_slide() ==
               List.first(presentation.slides)
    end
  end

  describe "slide/1" do
    test "returns the title of the slide at the given index" do
      presentation = Presentations.load()
      second_slide = Enum.at(presentation.slides, 1)
      assert second_slide == Presentations.slide(presentation, at_index: 1)
    end
  end

  describe "set_current_slide/2" do
    test "sets the active index of the presentation to the given index" do
      presentation = Presentations.load()
      updated = Presentations.set_current_slide(presentation, 2)
      assert updated.active_index == 2
    end
  end

  describe "subscribe/0" do
    setup :subscribe

    test "subscribes the current process to the presentations:lobby pubsub topic" do
      LiveDeckWeb.Endpoint.broadcast("presentations:lobby", "some_event", %{message: "test"})

      assert_receive %Phoenix.Socket.Broadcast{
        event: "some_event",
        payload: %{message: "test"},
        topic: "presentations:lobby"
      }
    end
  end

  defp subscribe(context) do
    Presentations.subscribe()
    context
  end

  defp load_presentation(context) do
    Map.merge(context, %{presentation: Presentations.load()})
  end
end
