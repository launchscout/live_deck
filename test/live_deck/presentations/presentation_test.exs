defmodule LiveDeck.Presentations.PresentationTest do
  alias LiveDeck.Presentations.Presentation
  use ExUnit.Case

  describe "new/0" do
    test "creates a Presentation struct" do
      assert %Presentation{} = Presentation.new()
    end
  end
end
