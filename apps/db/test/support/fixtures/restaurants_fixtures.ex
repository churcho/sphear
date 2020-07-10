defmodule Db.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Restaurants` context.
  """


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
      |> Db.Feeders.create_restaurant()

      restaurant
  end
end
