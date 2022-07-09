defmodule GymApi.Repo do
  use Ecto.Repo,
    otp_app: :gym_api,
    adapter: Ecto.Adapters.Postgres
end
