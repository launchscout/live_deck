defmodule LiveDeckWeb.Admin.SlideCardComponent do
  @moduledoc """
  Component that represents a single slide object.
  """
  use Phoenix.LiveComponent
  alias LiveDeckWeb.AdminView

  def render(assigns), do: AdminView.render("slide_card_component.html", assigns)
end
