defmodule Db.MerchandiseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Merchandise` context.
  """
  alias Db.Merchandise
  import Db.RestaurantsFixtures

  def product_name, do: Faker.Pizza.pizza()
  def valid_price, do: Faker.random_between(7000, 10000)

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
    product1 = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    product2 = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    product3 = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    product4 = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    [product1, product2, product3, product4]
  end
end
