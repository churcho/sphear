defmodule MatxWeb.Api.TrollController do
  use MatxWeb, :controller

  def troll(conn, _) do
    render(conn, "info.json", message: "troll")
  end
end