defmodule GymApi.GymFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GymApi.Gym` context.
  """

  @doc """
  Generate a level.
  """
  def level_fixture(attrs \\ %{}) do
    {:ok, level} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> GymApi.Gym.create_level()

    level
  end

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        cadence: 42,
        interval: 42,
        name: "some name",
        repetition: 42
      })
      |> GymApi.Gym.create_exercise()

    exercise
  end
end
