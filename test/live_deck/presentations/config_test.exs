defmodule LiveDeck.Presentations.ConfigTest do
  use ExUnit.Case
  alias LiveDeck.Presentations.Config

  describe "notes/2" do
    test "returns slide config with notes added in" do
      slides = Config.slides() |> Config.insert_notes()

      assert List.first(slides).notes == "Hi. I am your notes."
    end
  end
end
