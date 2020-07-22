defmodule Db.MerchandiseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Merchandise` context.
  """
  alias Db.Feeders
  alias Db.Merchandise

  import Db.RestaurantsFixtures

  defp random_3() do
    last_3(System.unique_integer())
  end
  defp last_3(integer) do
    String.slice(Integer.to_string(integer), -3, 3)
  end

  def product_name, do: "product #{random_3()}"
  def valid_price, do: 1337_00

  def product_fixture(attrs \\ %{}) do
    restaurant = restaurant_fixture()
    menu = menu_fixture(%{restaurant_id: restaurant.id})

    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: product_name(),
        menu_id: menu.id,
        price: valid_price()
      })
      |> Merchandise.create_product()
      
    product
  end

  def create_products(menu) do
    product1 = product_fixture(%{menu_id: menu.id, name: "test product 1", price: 99_90})
    product2 = product_fixture(%{menu_id: menu.id, name: "test product 2", price: 49_90})
    product3 = product_fixture(%{menu_id: menu.id, name: "test product 3", price: 199_00})
    product4 = product_fixture(%{menu_id: menu.id, name: "test product 4", price: 999_90})
    [product1, product2, product3, product4]
  end
end
