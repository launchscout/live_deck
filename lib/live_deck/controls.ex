defmodule LiveDeck.Controls do
  @moduledoc """
  Context module for manipulating presentation
  controls.
  """
  use Agent
  alias LiveDeck.Presentations

  def start_link do
    Agent.start_link(fn -> Presentations.load() end, name: __MODULE__)
  end

  def get_presentation do
    Agent.get(__MODULE__, & &1)
  end
end
