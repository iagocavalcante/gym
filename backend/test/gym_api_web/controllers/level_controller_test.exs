defmodule GymApiWeb.LevelControllerTest do
  use GymApiWeb.ConnCase

  import GymApi.GymFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all levels", %{conn: conn} do
      conn = get(conn, Routes.level_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Levels"
    end
  end

  describe "new level" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.level_path(conn, :new))
      assert html_response(conn, 200) =~ "New Level"
    end
  end

  describe "create level" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.level_path(conn, :create), level: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.level_path(conn, :show, id)

      conn = get(conn, Routes.level_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Level"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.level_path(conn, :create), level: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Level"
    end
  end

  describe "edit level" do
    setup [:create_level]

    test "renders form for editing chosen level", %{conn: conn, level: level} do
      conn = get(conn, Routes.level_path(conn, :edit, level))
      assert html_response(conn, 200) =~ "Edit Level"
    end
  end

  describe "update level" do
    setup [:create_level]

    test "redirects when data is valid", %{conn: conn, level: level} do
      conn = put(conn, Routes.level_path(conn, :update, level), level: @update_attrs)
      assert redirected_to(conn) == Routes.level_path(conn, :show, level)

      conn = get(conn, Routes.level_path(conn, :show, level))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, level: level} do
      conn = put(conn, Routes.level_path(conn, :update, level), level: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Level"
    end
  end

  describe "delete level" do
    setup [:create_level]

    test "deletes chosen level", %{conn: conn, level: level} do
      conn = delete(conn, Routes.level_path(conn, :delete, level))
      assert redirected_to(conn) == Routes.level_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.level_path(conn, :show, level))
      end
    end
  end

  defp create_level(_) do
    level = level_fixture()
    %{level: level}
  end
end
