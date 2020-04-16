defmodule LiveDeck.Controls.TimerTest do
  use ExUnit.Case
  alias LiveDeck.Controls.Timer

  describe "init/0" do
    test "returns an unpopulated Timer struct" do
      assert %Timer{} == Timer.init()
    end
  end

  describe "start/1" do
    test "initializes a timer" do
      Timer.start(50)
      assert_receive :tick
    end
  end

  describe "stop/1" do
    test "stops a timer" do
      timer = Timer.start(50)
      assert_receive :tick

      Timer.stop(timer)
      refute_receive :tick
    end
  end
end
