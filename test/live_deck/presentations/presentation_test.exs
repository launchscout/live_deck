defmodule LiveDeck.Presentations.PresentationTest do
  alias LiveDeck.Presentations.Presentation
  use ExUnit.Case

  describe "new/0" do
    test "creates a Presentation struct" do
      assert %Presentation{} = presentation = Presentation.new()

      assert presentation.current_slide ==
               ""
               |> LiveDeck.Fake.File.ls!()
               |> List.first()
               |> String.replace(".eex", "")
    end
  end
end
