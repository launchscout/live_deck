defmodule LiveDeck.ControlsTest do
  use ExUnit.Case
  alias LiveDeck.{Controls, Presentations}
  alias LiveDeck.Presentations.Presentation

  setup do
    Controls.start()
    :ok
  end

  describe "Controls" do
    test "initializes state to a new Presentation struct" do
      assert Presentations.load() == Agent.get(Controls.Control, fn state -> state end)
    end
  end

  describe "get_presentation/1" do
    test "returns the current presentation state" do
      assert Presentations.load() == Controls.get_presentation()
    end
  end

  describe "navigate/1" do
    setup :subscribe

    test "increments current slide of presentation when passed :next" do
      assert %Presentation{active_index: 1} = Controls.navigate(:next)
    end

    test "decrements current slide of presentation when passed :prev" do
      Controls.navigate(:next)
      assert %Presentation{active_index: 0} = Controls.navigate(:prev)
    end

    test "navigating triggers a presentation_update pubsub event to be published" do
      Controls.navigate(:next)

      assert_receive %Phoenix.Socket.Broadcast{
        event: "presentation_update",
        payload: %Presentation{}
      }
    end
  end

  describe "subscribe/0" do
    setup :subscribe

    test "subscribes the current process to the controls:channel pubsub topic" do
      LiveDeckWeb.Endpoint.broadcast("controls:channel", "some_event", %{message: "test"})

      assert_receive %Phoenix.Socket.Broadcast{
        event: "some_event",
        payload: %{message: "test"},
        topic: "controls:channel"
      }
    end
  end

  describe "publish/2" do
    setup :subscribe

    test "publishes the event given as the first parameter with the payload to the controls:channel pubsub topic" do
      Controls.publish("new_presentation", %Presentation{active_index: 1})

      assert_receive %Phoenix.Socket.Broadcast{
        topic: "controls:channel",
        event: "new_presentation",
        payload: %Presentation{
          active_index: 1,
          last_index: nil,
          slides: []
        }
      }
    end
  end

  defp subscribe(context) do
    Controls.subscribe()
    context
  end
end
