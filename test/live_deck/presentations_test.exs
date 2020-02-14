defmodule LiveDeck.PresentationsTest do
  alias LiveDeck.Presentations
  use ExUnit.Case

  describe "list_slides/0" do
    test "returns a list of all slides" do
      for slide <- Presentations.list_slides() do
        assert String.ends_with?(slide, ".html")
      end
    end
  end
end
