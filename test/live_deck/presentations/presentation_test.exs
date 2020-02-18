defmodule LiveDeck.Presentations.PresentationTest do
  alias LiveDeck.Presentations.Presentation
  use ExUnit.Case

  describe "new/0" do
    test "creates a Presentation struct" do
      assert %Presentation{active_index: 0} = Presentation.new()
    end
  end

  describe "next_slide/1" do
    test "updates current slide if there is a next slide" do
      assert %Presentation{active_index: 1} = Presentation.new() |> Presentation.next_slide()
    end
  end
end
