defmodule SynapsWeb.DemoController do
  use SynapsWeb, :controller

  def index(conn, _) do
    render(conn, "demo.html", live_module: "Elixir.SynapsWeb.DemoLive")
  end
end