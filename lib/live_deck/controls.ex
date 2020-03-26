defmodule LiveDeck.Controls do
  @moduledoc """
  Context module for manipulating presentation
  controls.
  """
  alias LiveDeck.Controls.Control
  alias LiveDeck.Presentations

  @doc """
  Ensures the Control process is started.
  """
  @spec start() :: Agent.on_start()
  def start, do: Control.start_link()

  @doc """
  Returns the current presentation.
  """
  @spec get_presentation() :: Presentations.presentation()
  def get_presentation, do: Control.get_presentation()

  @spec navigate(:next | :prev) :: Presentations.presentation()
  def navigate(:next), do: Control.next_slide()
  def navigate(:prev), do: Control.prev_slide()
end
