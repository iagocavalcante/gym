defmodule GymApiWeb.Api.LevelController do
  use GymApiWeb, :controller

  alias GymApi.Gym
  alias GymApi.Gym.Level

  action_fallback(GymApiWeb.FallbackController)

  def index(conn, _params) do
    levels = Gym.list_levels()
    render(conn, "index.json", levels: levels)
  end

  def create(conn, %{"level" => level_params}) do
    with {:ok, %Level{} = level} <- Gym.create_level(level_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.level_path(conn, :show, level))
      |> render("show.json", level: level)
    end
  end

  def show(conn, %{"id" => id}) do
    level = Gym.get_level!(id)
    render(conn, "show.json", level: level)
  end

  def update(conn, %{"id" => id, "level" => level_params}) do
    level = Gym.get_level!(id)

    with {:ok, %Level{} = level} <- Gym.update_level(level, level_params) do
      render(conn, "show.json", level: level)
    end
  end

  def delete(conn, %{"id" => id}) do
    level = Gym.get_level!(id)

    with {:ok, %Level{}} <- Gym.delete_level(level) do
      send_resp(conn, :no_content, "")
    end
  end
end
