defmodule GymApi.GymTest do
  use GymApi.DataCase

  alias GymApi.Gym

  describe "levels" do
    alias GymApi.Gym.Level

    import GymApi.GymFixtures

    @invalid_attrs %{name: nil}

    test "list_levels/0 returns all levels" do
      level = level_fixture()
      assert Gym.list_levels() == [level]
    end

    test "get_level!/1 returns the level with given id" do
      level = level_fixture()
      assert Gym.get_level!(level.id) == level
    end

    test "create_level/1 with valid data creates a level" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Level{} = level} = Gym.create_level(valid_attrs)
      assert level.name == "some name"
    end

    test "create_level/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gym.create_level(@invalid_attrs)
    end

    test "update_level/2 with valid data updates the level" do
      level = level_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Level{} = level} = Gym.update_level(level, update_attrs)
      assert level.name == "some updated name"
    end

    test "update_level/2 with invalid data returns error changeset" do
      level = level_fixture()
      assert {:error, %Ecto.Changeset{}} = Gym.update_level(level, @invalid_attrs)
      assert level == Gym.get_level!(level.id)
    end

    test "delete_level/1 deletes the level" do
      level = level_fixture()
      assert {:ok, %Level{}} = Gym.delete_level(level)
      assert_raise Ecto.NoResultsError, fn -> Gym.get_level!(level.id) end
    end

    test "change_level/1 returns a level changeset" do
      level = level_fixture()
      assert %Ecto.Changeset{} = Gym.change_level(level)
    end
  end

  describe "exercise" do
    alias GymApi.Gym.Exercise

    import GymApi.GymFixtures

    @invalid_attrs %{cadence: nil, interval: nil, name: nil, repetition: nil}

    test "list_exercise/0 returns all exercise" do
      exercise = exercise_fixture()
      assert Gym.list_exercise() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert Gym.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{cadence: 42, interval: 42, name: "some name", repetition: 42}

      assert {:ok, %Exercise{} = exercise} = Gym.create_exercise(valid_attrs)
      assert exercise.cadence == 42
      assert exercise.interval == 42
      assert exercise.name == "some name"
      assert exercise.repetition == 42
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gym.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{cadence: 43, interval: 43, name: "some updated name", repetition: 43}

      assert {:ok, %Exercise{} = exercise} = Gym.update_exercise(exercise, update_attrs)
      assert exercise.cadence == 43
      assert exercise.interval == 43
      assert exercise.name == "some updated name"
      assert exercise.repetition == 43
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = Gym.update_exercise(exercise, @invalid_attrs)
      assert exercise == Gym.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = Gym.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> Gym.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = Gym.change_exercise(exercise)
    end
  end
end
