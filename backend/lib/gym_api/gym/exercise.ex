defmodule GymApi.Gym.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercise" do
    field :cadence, :integer
    field :interval, :integer
    field :name, :string
    field :repetition, :integer

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :repetition, :interval, :cadence])
    |> validate_required([:name, :repetition, :interval, :cadence])
  end
end
