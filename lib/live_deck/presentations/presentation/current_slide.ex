defmodule LiveDeck.Presentations.Presentation.CurrentSlide do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def get_current do
    Agent.get(__MODULE__, & &1)
  end

  def increment_current do
    Agent.update(__MODULE__, &(&1 + 1))
  end
end
