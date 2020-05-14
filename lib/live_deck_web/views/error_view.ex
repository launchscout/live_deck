defmodule LiveDeckWeb.ErrorView do
  use LiveDeckWeb, :view

  def render("404.html", assigns) do
    render("404_page.html", assigns)
  end

  def render("500.html", assigns) do
    render("500_page.html", assigns)
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
