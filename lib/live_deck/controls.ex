defmodule LiveDeck.Controls do
  @moduledoc """
  Context module for manipulating presentation
  controls.
  """
  alias LiveDeck.Controls.Control
  alias LiveDeck.Presentations
  @pubsub_topic "controls:channel"

  @doc """
  Ensures the Control process is started.
  """
  @spec start() :: Agent.on_start()
  def start, do: Control.start_link()

  @doc """
  Subscribes the current process to the
  controls:channel PubSub topic.
  """
  @spec subscribe() :: no_return()
  def subscribe, do: LiveDeckWeb.Endpoint.subscribe(@pubsub_topic)

  @doc """
  Publishes the event given as the first parameter
  with the payload given as the second to the
  `controls:channel` PubSub topic.
  """
  @spec publish(String.t(), map()) :: :ok | {:error, term()}
  def publish(event, payload) do
    LiveDeckWeb.Endpoint.broadcast(@pubsub_topic, event, payload)
  end

  @doc """
  Returns the current presentation.
  """
  @spec get_presentation() :: Presentations.presentation()
  def get_presentation, do: Control.get_presentation()

  @spec navigate(:next | :prev) :: Presentations.presentation()
  def navigate(:next) do
    presentation = Control.next_content()
    publish("presentation_update", presentation)
    presentation
  end

  def navigate(:prev) do
    presentation = Control.prev_content()
    publish("presentation_update", presentation)
    presentation
  end

  @doc """
  Sets the current slide index.
  """
  @spec set_current_slide(non_neg_integer()) :: Presentations.presentation()
  def set_current_slide(index) do
    presentation = Control.set_current_slide(get_presentation(), index)
    publish("presentation_update", presentation)
    presentation
  end
end
