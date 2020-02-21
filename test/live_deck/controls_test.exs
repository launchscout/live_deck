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
      assert Presentations.load() == Agent.get(Controls, fn state -> state end)
    end
  end

  describe "get_presentation/1" do
    test "returns the current presentation state" do
      assert Presentations.load() == Controls.get_presentation()
    end
  end

  describe "navigate/1" do
    test "increments current slide of presentation when passed :next" do
      assert %Presentation{active_index: 1} = Controls.navigate(:next)
    end

    test "decrements current slide of presentation when passed :prev" do
      # this is lazy test setup
      Controls.navigate(:next)
      assert %Presentation{active_index: 0} = Controls.navigate(:prev)
    end
  end
end
