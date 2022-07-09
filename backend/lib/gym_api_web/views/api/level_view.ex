defmodule GymApiWeb.Api.LevelView do
  use GymApiWeb, :view
  alias GymApiWeb.Api.LevelView

  def render("index.json", %{levels: levels}) do
    %{data: render_many(levels, LevelView, "level.json")}
  end

  def render("show.json", %{level: level}) do
    %{data: render_one(level, LevelView, "level.json")}
  end

  def render("level.json", %{level: level}) do
    %{
      id: level.id,
      name: level.name
    }
  end
end
