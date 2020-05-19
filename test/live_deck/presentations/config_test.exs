defmodule LiveDeck.Presentations.ConfigTest do
  use ExUnit.Case
  alias LiveDeck.Presentations.Config

  describe "slides/0" do
    test "returns slide config with notes added in" do
      assert List.first(Config.slides()).notes == "Hi. I am your notes."
    end

    test "sets a default background on slides" do
      assert Enum.all?(Config.slides(), fn slide ->
               slide.background_color
             end)
    end
  end
end
