defmodule MatxWeb.Api.RestaurantView do
  use MatxWeb, :view

  def render("index.json", %{restaurants: restaurants}) do
    %{restaurants: render_many(restaurants, MatxWeb.Api.RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    render_one(restaurant, MatxWeb.Api.RestaurantView, "restaurant.json")
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{
      id: restaurant.id,
      created: restaurant.inserted_at,
      name: restaurant.name,
      address: restaurant.address,
      url: restaurant.url
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
