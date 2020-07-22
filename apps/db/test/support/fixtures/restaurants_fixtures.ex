defmodule Db.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Restaurants` context.
  """

  alias Db.Feeders

  def menu_name, do: Faker.Pizza.combo()

  def restaurant_name() do
    Faker.Pizza.company()
  end
  def valid_url(name) do
    name =
      name
      |> String.downcase
      |> String.replace(" ", "-")
      |> String.replace("’", "")
      |> String.replace("'", "")
    "https://#{name}.se"
  end
  def valid_address, do: Faker.Address.street_address()

  def restaurant_fixture(attrs \\ %{}) do
    name = restaurant_name()
    
    {:ok, restaurant} =  
      attrs
      |> Enum.into(%{
        name: name,
        url: valid_url(name),
        address: valid_address()
      })
      |> Feeders.create_restaurant()

      restaurant
  end

  def menu_fixture(attrs \\ %{}) do
    restaurant = restaurant_fixture()

    {:ok, menu} =
      attrs
      |> Enum.into(%{
        name: menu_name(),
        restaurant_id: restaurant.id
      })
      |> Feeders.create_menu()

    menu
  end

  def create_menus(restaurant) do
    menu1 = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    menu2 = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    menu3 = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    menu4 = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    [menu1, menu2, menu3, menu4]
  end
end
