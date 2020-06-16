defmodule Blippx.Repo do
  use Ecto.Repo,
    otp_app: :blippx,
    adapter: Ecto.Adapters.Postgres
end
