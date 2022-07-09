defmodule GymApiWeb.PageController do
  use GymApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
