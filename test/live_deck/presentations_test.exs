defmodule LiveDeck.PresentationsTest do
  alias LiveDeck.Presentations
  use ExUnit.Case

  describe "list_slides/0" do
    test "returns a list of all slides" do
      assert length(Presentations.list_slides()) == 4
    end
  end
end
