defmodule Db.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Restaurants` context.
  """
  alias Db.Feeders
  alias Db.Merchandise

  defp random_3() do
    last_3(System.unique_integer())
  end
  defp last_3(integer) do
    String.slice(Integer.to_string(integer), -3, 3)
  end

  def menu_name, do: "menu #{random_3()}"

  def restaurant_name, do: "restaurant #{random_3()}"
  def valid_url, do: "https://#{random_3()}.io"
  def valid_address, do: "trollvägen #{random_3()}"

  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        name: restaurant_name(),
        url: valid_url(),
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
    menu1 = menu_fixture(%{restaurant_id: restaurant.id, name: "test menu1"})
    menu2 = menu_fixture(%{restaurant_id: restaurant.id, name: "test menu2"})
    menu3 = menu_fixture(%{restaurant_id: restaurant.id, name: "test menu3"})
    menu4 = menu_fixture(%{restaurant_id: restaurant.id, name: "test menu4"})
    [menu1, menu2, menu3, menu4]
  end
end
