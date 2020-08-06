defmodule MatxWeb.Api.RestaurantView do
  use MatxWeb, :view

  def render("index.json", %{restaurants: restaurants}) do
    %{restaurants: render_many(restaurants, MatxWeb.Api.RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    render_one(restaurant, MatxWeb.Api.RestaurantView, "restaurant.json")
  end

  def render("restaurant.json", %{restaurant: %{menus: %Ecto.Association.NotLoaded{}} = restaurant}) do
    %{
      id: restaurant.id,
      created: restaurant.inserted_at,
      name: restaurant.name,
      hidden: restaurant.hidden,
      address: restaurant.address,
      url: restaurant.url,
      menus: [], #render_many(menus, MatxWeb.Api.MenuView, "menu.json")
      unlisted_products: []
    }
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    menus = EctoList.ordered_items_list(restaurant.menus, restaurant.menus_sequence)
    %{
      id: restaurant.id,
      created: restaurant.inserted_at,
      name: restaurant.name,
      hidden: restaurant.hidden,
      address: restaurant.address,
      url: restaurant.url,
      menus: render_many(menus, MatxWeb.Api.MenuView, "menu.json"),
      unlisted_products: render_many(restaurant.unlisted_products, MatxWeb.Api.ProductView, "show.json")
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
