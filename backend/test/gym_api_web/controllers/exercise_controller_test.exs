defmodule GymApiWeb.ExerciseControllerTest do
  use GymApiWeb.ConnCase

  import GymApi.GymFixtures

  alias GymApi.Gym.Exercise

  @create_attrs %{
    cadence: 42,
    interval: 42,
    name: "some name",
    repetition: 42
  }
  @update_attrs %{
    cadence: 43,
    interval: 43,
    name: "some updated name",
    repetition: 43
  }
  @invalid_attrs %{cadence: nil, interval: nil, name: nil, repetition: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all exercise", %{conn: conn} do
      conn = get(conn, Routes.exercise_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create exercise" do
    test "renders exercise when data is valid", %{conn: conn} do
      conn = post(conn, Routes.exercise_path(conn, :create), exercise: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.exercise_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "cadence" => 42,
               "interval" => 42,
               "name" => "some name",
               "repetition" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.exercise_path(conn, :create), exercise: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update exercise" do
    setup [:create_exercise]

    test "renders exercise when data is valid", %{conn: conn, exercise: %Exercise{id: id} = exercise} do
      conn = put(conn, Routes.exercise_path(conn, :update, exercise), exercise: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.exercise_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "cadence" => 43,
               "interval" => 43,
               "name" => "some updated name",
               "repetition" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, exercise: exercise} do
      conn = put(conn, Routes.exercise_path(conn, :update, exercise), exercise: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete exercise" do
    setup [:create_exercise]

    test "deletes chosen exercise", %{conn: conn, exercise: exercise} do
      conn = delete(conn, Routes.exercise_path(conn, :delete, exercise))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.exercise_path(conn, :show, exercise))
      end
    end
  end

  defp create_exercise(_) do
    exercise = exercise_fixture()
    %{exercise: exercise}
  end
end
