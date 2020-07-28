defmodule Db.MerchandiseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Merchandise` context.
  """
  alias Db.Merchandise
  import Db.RestaurantsFixtures

  def product_name, do: Faker.Pizza.pizza()
  def product_extra_name, do: Faker.Pizza.sauce()
  def valid_price, do: Faker.random_between(7000, 10000)
  def valid_extra_price, do: Faker.random_between(1000, 3000)

  def product_fixture(attrs \\ %{}) do
    menu_id =
      case attrs[:menu_id] do
        nil ->
          {:ok, restaurant} = restaurant_fixture()
          {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
          menu.id
        menu_id ->
          menu_id
      end
  
    attrs
    |> Enum.into(%{
      name: product_name(),
      menu_id: menu_id,
      price: valid_price()
    })
    |> Merchandise.create_product()
  end

  def unlisted_product_fixture(attrs \\ %{}) do
    restaurant_id =
      case attrs[:restaurant_id] do
        nil ->
          {:ok, restaurant} = restaurant_fixture()
          restaurant.id
        restaurant_id ->
          restaurant_id
      end

    attrs
    |> Enum.into(%{
      name: product_extra_name(),
      restaurant_id: restaurant_id,
      price: valid_extra_price()
    })
    |> Merchandise.create_unlisted_product()
  end

  def create_products(menu) do
    {:ok, product1} = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    {:ok, product2} = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    {:ok, product3} = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    {:ok, product4} = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
    [product1, product2, product3, product4]
  end

  # Product Extra Menu
  def product_extra_menu_fixture(attrs \\ %{}) do
    product_id =
      case attrs[:product_id] do
        nil ->
          {:ok, restaurant} = restaurant_fixture()
          {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
          {:ok, product} = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
          product.id
        product_id ->
          product_id
      end
    
    attrs
    |> Enum.into(%{
      name: "Sauces",
      pick_only_one: false,
      product_id: product_id,
    })
    |> Merchandise.create_product_extra_menu()
  end

  def create_product_extra_menus(product) do
    {:ok, product_extra_menu_1} = product_extra_menu_fixture(%{product_id: product.id, name: "Sauces"})
    {:ok, product_extra_menu_2} = product_extra_menu_fixture(%{product_id: product.id, name: "Dipps"})
    [product_extra_menu_1, product_extra_menu_2]
  end

  # Product Extra
  def product_extra_fixture(attrs \\ %{}) do
    {:ok, restaurant} = restaurant_fixture()

    product_extra_menu_id =
      case attrs[:product_extra_menu_id] do
        nil ->
          {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
          {:ok, product} = product_fixture(%{menu_id: menu.id, name: product_name(), price: valid_price()})
          {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product.id})
          product_extra_menu.id
        product_extra_menu_id ->
          product_extra_menu_id
      end

    product_id =
      case attrs[:product_id] do
        nil ->
          {:ok, unlisted_product} = unlisted_product_fixture(%{restaurant_id: restaurant.id, name: product_extra_name(), price: valid_extra_price()})
          unlisted_product.id
        product_id ->
          product_id
      end
    
    attrs
    |> Enum.into(%{
      new_name: product_extra_name(),
      new_price: valid_extra_price(),
      product_extra_menu_id: product_extra_menu_id,
      product_id: product_id
    })
    |> Merchandise.create_product_extra()
  end

  def create_product_extras(product_extra_menu) do
    {:ok, product_extra_1} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id, new_name: product_extra_name(), new_price: valid_extra_price()})
    {:ok, product_extra_2} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id, new_name: product_extra_name(), new_price: valid_extra_price()})
    {:ok, product_extra_3} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id, new_name: product_extra_name(), new_price: valid_extra_price()})
    {:ok, product_extra_4} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id, new_name: product_extra_name(), new_price: valid_extra_price()})
    [product_extra_1, product_extra_2, product_extra_3, product_extra_4]
  end
end
