defmodule LiveDeckWeb.ThumbnailControllerTest do
  use LiveDeckWeb.ConnCase

  alias LiveDeck.Presentation

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:thumbnail) do
    {:ok, thumbnail} = Presentation.create_thumbnail(@create_attrs)
    thumbnail
  end

  describe "index" do
    test "lists all thumbnails", %{conn: conn} do
      conn = get(conn, Routes.thumbnail_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Thumbnails"
    end
  end

  describe "new thumbnail" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.thumbnail_path(conn, :new))
      assert html_response(conn, 200) =~ "New Thumbnail"
    end
  end

  describe "create thumbnail" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thumbnail_path(conn, :create), thumbnail: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.thumbnail_path(conn, :show, id)

      conn = get(conn, Routes.thumbnail_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Thumbnail"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.thumbnail_path(conn, :create), thumbnail: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Thumbnail"
    end
  end

  describe "edit thumbnail" do
    setup [:create_thumbnail]

    test "renders form for editing chosen thumbnail", %{conn: conn, thumbnail: thumbnail} do
      conn = get(conn, Routes.thumbnail_path(conn, :edit, thumbnail))
      assert html_response(conn, 200) =~ "Edit Thumbnail"
    end
  end

  describe "update thumbnail" do
    setup [:create_thumbnail]

    test "redirects when data is valid", %{conn: conn, thumbnail: thumbnail} do
      conn = put(conn, Routes.thumbnail_path(conn, :update, thumbnail), thumbnail: @update_attrs)
      assert redirected_to(conn) == Routes.thumbnail_path(conn, :show, thumbnail)

      conn = get(conn, Routes.thumbnail_path(conn, :show, thumbnail))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, thumbnail: thumbnail} do
      conn = put(conn, Routes.thumbnail_path(conn, :update, thumbnail), thumbnail: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Thumbnail"
    end
  end

  describe "delete thumbnail" do
    setup [:create_thumbnail]

    test "deletes chosen thumbnail", %{conn: conn, thumbnail: thumbnail} do
      conn = delete(conn, Routes.thumbnail_path(conn, :delete, thumbnail))
      assert redirected_to(conn) == Routes.thumbnail_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.thumbnail_path(conn, :show, thumbnail))
      end
    end
  end

  defp create_thumbnail(_) do
    thumbnail = fixture(:thumbnail)
    {:ok, thumbnail: thumbnail}
  end
end
