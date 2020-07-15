defmodule MatxWeb.Api.RestaurantController do
  use MatxWeb, :controller

  alias Db.Feeders

  def index(conn, _) do
    render(conn, "index.json", restaurants: Feeders.list_restaurants())
  end

  def show(conn, %{"id" => id}) do
    case Feeders.get_restaurant(id) do
      {:error, _} ->
        render(conn, "error.json", message: "Restaurangen hittades inte")
      {:ok, restaurant} ->
        render(conn, "show.json", restaurant: restaurant)
    end
  end
end
