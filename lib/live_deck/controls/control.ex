defmodule LiveDeck.Controls.Control do
  @moduledoc """
  Implements an Agent that stores
  a presentation struct.

  This module also exposes functions that
  let callers manipulate the presentation
  struct stored in state and fetch data
  from the Agent.
  """
  use Agent
  alias LiveDeck.Presentations

  @spec start_link() :: Agent.on_start()
  def start_link do
    Agent.start_link(fn -> Presentations.load() end, name: __MODULE__)
  end

  @spec get_presentation() :: Presentations.presentation()
  def get_presentation do
    Agent.get(__MODULE__, & &1)
  end

  @spec set_current_slide(Presentations.presentation(), non_neg_integer()) ::
          Presentations.presentation()
  def set_current_slide(presentation, index) do
    Agent.get_and_update(__MODULE__, fn _state ->
      updated = Presentations.set_current_slide(presentation, index)
      {updated, updated}
    end)
  end

  def next_content() do
    Agent.get_and_update(__MODULE__, fn state ->
      updated_presentation = Presentations.next_content(state)
      {updated_presentation, updated_presentation}
    end)
  end

  def prev_content do
    Agent.get_and_update(__MODULE__, fn state ->
      updated_presentation = Presentations.prev_content(state)
      {updated_presentation, updated_presentation}
    end)
  end
end
