defmodule LiveDeckWeb.ErrorViewTest do
  use LiveDeckWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  setup context do
    private_assigns = context.conn.private

    updated =
      Map.put(
        context.conn,
        :private,
        Map.put(private_assigns, :phoenix_endpoint, LiveDeckWeb.Endpoint)
      )

    {:ok, Map.merge(context, %{conn: updated})}
  end

  test "renders 404.html", %{conn: conn} do
    assert render_to_string(LiveDeckWeb.ErrorView, "404.html", conn: conn) =~
             ~s(data-testid="404-page")
  end

  test "renders 500.html", %{conn: conn} do
    assert render_to_string(LiveDeckWeb.ErrorView, "500.html", conn: conn) =~
             ~s(data-testid="500-page")
  end

  test "template not found", %{conn: conn} do
    assert LiveDeckWeb.ErrorView.template_not_found("some_non_existent_template.html", conn: conn) =~
             "Internal Server Error"
  end
end
