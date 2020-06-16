defmodule Proxy.PageController do
  use Proxy, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
