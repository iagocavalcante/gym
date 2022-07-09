defmodule GymApi.Repo.Migrations.CreateExercise do
  use Ecto.Migration

  def change do
    create table(:exercise) do
      add :name, :string
      add :repetition, :integer
      add :interval, :integer
      add :cadence, :integer

      timestamps()
    end
  end
end
