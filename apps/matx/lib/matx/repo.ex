defmodule Matx.Repo do
  use Ecto.Repo,
    otp_app: :matx,
    adapter: Ecto.Adapters.Postgres
end
