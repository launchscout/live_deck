defmodule LiveDeckWeb.Admin.SlideCardComponent do
  use Phoenix.LiveComponent
  alias LiveDeckWeb.AdminView

  def render(assigns), do: AdminView.render("slide_card_component.html", assigns)
end
