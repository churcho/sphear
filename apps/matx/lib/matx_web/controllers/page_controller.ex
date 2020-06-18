defmodule MatxWeb.PageController do
    use MatxWeb, :controller

    def index(conn, _params) do
      render(conn, "index.html")
    end

    def button(conn, _params) do
      render(conn, "button.html")
    end
  end
  