defmodule MatxWeb.Api.RestaurantView do
  use MatxWeb, :view

  def render("index.json", %{restaurants: restaurants}) do
    %{success: %{restaurants: render_many(restaurants, MatxWeb.Api.RestaurantView, "restaurant.json")}}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{success: %{restaurant: render_one(restaurant, MatxWeb.Api.RestaurantView, "restaurant.json")}}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{name: restaurant.name, address: restaurant.address, url: restaurant.url}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end