defmodule Db.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Restaurants` context.
  """

  def restaurant_name, do: "restaurant #{System.unique_integer()}"
  def valid_url, do: "https://#{System.unique_integer()}.io"
  def valid_address, do: "trollvägen #{System.unique_integer()}"

  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        name: restaurant_name(),
        url: valid_url(),
        address: valid_address()
      })
      |> Db.Feeders.create_restaurant()

      restaurant
  end
end
