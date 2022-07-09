defmodule GymApiWeb.Api.ExerciseController do
  use GymApiWeb, :controller

  alias GymApi.Gym
  alias GymApi.Gym.Exercise

  action_fallback(GymApiWeb.FallbackController)

  def index(conn, _params) do
    exercise = Gym.list_exercise()
    render(conn, "index.json", exercise: exercise)
  end

  def create(conn, %{"exercise" => exercise_params}) do
    with {:ok, %Exercise{} = exercise} <- Gym.create_exercise(exercise_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.exercise_path(conn, :show, exercise))
      |> render("show.json", exercise: exercise)
    end
  end

  def show(conn, %{"id" => id}) do
    exercise = Gym.get_exercise!(id)
    render(conn, "show.json", exercise: exercise)
  end

  def update(conn, %{"id" => id, "exercise" => exercise_params}) do
    exercise = Gym.get_exercise!(id)

    with {:ok, %Exercise{} = exercise} <- Gym.update_exercise(exercise, exercise_params) do
      render(conn, "show.json", exercise: exercise)
    end
  end

  def delete(conn, %{"id" => id}) do
    exercise = Gym.get_exercise!(id)

    with {:ok, %Exercise{}} <- Gym.delete_exercise(exercise) do
      send_resp(conn, :no_content, "")
    end
  end
end
