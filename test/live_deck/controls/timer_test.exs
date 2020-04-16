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

  describe "tick/1" do
    test "increments the time by one second" do
      assert ~T[00:00:01.000000] == Timer.tick(Timer.init()).time
    end
  end

  describe "string interpolation" do
    test "returns time in MM:SS format" do
      assert "0:00" == "#{Timer.init()}"
    end
  end
end
