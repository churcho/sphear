defmodule Db.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Restaurants` context.
  """
  alias Db.Feeders


  defp random_3() do
    last_3(System.unique_integer())
  end
  defp last_3(integer) do
    String.slice(Integer.to_string(integer), -3, 3)
  end

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

  def create_menus(restaurant) do
    {:ok, menu1} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
    {:ok, menu2} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu2"})
    {:ok, menu3} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu3"})
    {:ok, menu4} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu4"})
    [menu1, menu2, menu3, menu4]
  end
end
