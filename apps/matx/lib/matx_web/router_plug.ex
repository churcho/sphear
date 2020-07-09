defmodule MatxWeb.RouterPlug do
  use Plug.Router

  # You must include these two Plugs or you'll receive an error
  # that's a little hard to track down. It's documented, but I
  # missed it initially
  plug :match
  plug :dispatch

  match "/api/*_", to: MatxWeb.RouterApi
  match _, to: MatxWeb.Router
end