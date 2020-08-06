defmodule Db.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Restaurants` context.
  """

  alias Db.Feeders

  def menu_name, do: Faker.Pizza.combo()
  def restaurant_name, do: Faker.Pizza.company()
  def valid_address, do: Faker.Address.street_address()
  def valid_url(name) do
    name =
      name
      |> String.downcase
      |> String.replace(" ", "-")
      |> String.replace("’", "")
      |> String.replace("'", "")
    "https://#{name}.se"
  end

  def restaurant_fixture(attrs \\ %{}) do 
    name = restaurant_name()
    
    attrs
    |> Enum.into(%{
      name: name,
      url: valid_url(name),
      address: valid_address(),
      hidden: false
    })
    |> Feeders.create_restaurant()
  end

  def menu_fixture(attrs \\ %{}) do
    restaurant_id =
      case attrs[:restaurant_id] do
        nil ->
          restaurant = restaurant_fixture()
          restaurant.id
        restaurant_id ->
          restaurant_id
      end
    
    attrs
    |> Enum.into(%{
      name: menu_name(),
      restaurant_id: restaurant_id,
      hidden: false
    })
    |> Feeders.create_menu()
  end

  def create_menus(restaurant) do
    {:ok, menu1} = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    {:ok, menu2} = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    {:ok, menu3} = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    {:ok, menu4} = menu_fixture(%{restaurant_id: restaurant.id, name: menu_name()})
    [menu1, menu2, menu3, menu4]
  end
end
