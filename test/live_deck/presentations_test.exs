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
      assert %Presentation{active_index: 1} = Presentations.load() |> Presentations.next_slide()
    end

    test "is a no-op when the active index is the last index" do
      presentation = %Presentation{
        slides: Presentations.load().slides,
        active_index: 3,
        last_index: 3
      }

      assert presentation == Presentations.next_slide(presentation)
    end
  end

  describe "prev_slide/1" do
    test "updates active index if there is a previous slide" do
      assert %Presentation{active_index: 0} =
               Presentations.prev_slide(%Presentation{active_index: 1})
    end

    test "is a no-op when the active index is 0" do
      presentation = %Presentation{
        slides: Presentations.load().slides,
        active_index: 0,
        last_index: 3
      }

      assert presentation == Presentations.prev_slide(presentation)
    end
  end

  describe "current_slide/1" do
    test "returns title of slide at active index" do
      presentation = Presentations.load()
      assert presentation |> Presentations.current_slide() == List.first(presentation.slides)
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
end
