defmodule GymApiWeb.ExerciseController do
  use GymApiWeb, :controller

  alias GymApi.Gym
  alias GymApi.Gym.Exercise

  def index(conn, _params) do
    exercise = Gym.list_exercise()
    render(conn, "index.html", exercise: exercise)
  end

  def new(conn, _params) do
    changeset = Gym.change_exercise(%Exercise{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"exercise" => exercise_params}) do
    case Gym.create_exercise(exercise_params) do
      {:ok, exercise} ->
        conn
        |> put_flash(:info, "Exercise created successfully.")
        |> redirect(to: Routes.exercise_path(conn, :show, exercise))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    exercise = Gym.get_exercise!(id)
    render(conn, "show.html", exercise: exercise)
  end

  def edit(conn, %{"id" => id}) do
    exercise = Gym.get_exercise!(id)
    changeset = Gym.change_exercise(exercise)
    render(conn, "edit.html", exercise: exercise, changeset: changeset)
  end

  def update(conn, %{"id" => id, "exercise" => exercise_params}) do
    exercise = Gym.get_exercise!(id)

    case Gym.update_exercise(exercise, exercise_params) do
      {:ok, exercise} ->
        conn
        |> put_flash(:info, "Exercise updated successfully.")
        |> redirect(to: Routes.exercise_path(conn, :show, exercise))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", exercise: exercise, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    exercise = Gym.get_exercise!(id)
    {:ok, _exercise} = Gym.delete_exercise(exercise)

    conn
    |> put_flash(:info, "Exercise deleted successfully.")
    |> redirect(to: Routes.exercise_path(conn, :index))
  end
end
