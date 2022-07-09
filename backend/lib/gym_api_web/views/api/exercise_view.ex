defmodule GymApiWeb.Api.ExerciseView do
  use GymApiWeb, :view
  alias GymApiWeb.Api.ExerciseView

  def render("index.json", %{exercise: exercise}) do
    %{data: render_many(exercise, ExerciseView, "exercise.json")}
  end

  def render("show.json", %{exercise: exercise}) do
    %{data: render_one(exercise, ExerciseView, "exercise.json")}
  end

  def render("exercise.json", %{exercise: exercise}) do
    %{
      id: exercise.id,
      name: exercise.name,
      repetition: exercise.repetition,
      interval: exercise.interval,
      cadence: exercise.cadence
    }
  end
end
