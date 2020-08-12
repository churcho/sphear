defmodule Db.SalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Db.Sales` context.
  """
  alias Db.Sales
  import Db.MerchandiseFixtures
  import Db.AccountsFixtures

  def valid_flat_discount(), do: Faker.random_between(1000, 3000)

  def cart_fixture(attrs \\ %{}) do
    user_id =
      case attrs[:user_id] do
        nil ->
          {:ok, user} = user_fixture()
          user.id
        user_id ->
          user_id
      end
  
    attrs
    |> Enum.into(%{
      user_id: user_id
    })
    |> Sales.create_cart()
  end

  def cart_item_fixture(attrs \\ %{}) do
    cart_id =
      case attrs[:cart_id] do
        nil ->
          {:ok, user} = user_fixture()
          {:ok, cart} = cart_fixture(%{user_id: user.id})
          cart.id
        cart_id ->
          cart_id
      end
    
    product_id =
      case attrs[:product_id] do
        nil ->
          {:ok, product} = product_fixture()
          product.id
        product_id ->
          product_id
      end  

    attrs
    |> Enum.into(%{
      cart_id: cart_id,
      product_id: product_id
    })
    |> Sales.create_cart_item()
  end

  def create_cart_items(cart_id) do
    {:ok, cart_item_1} = cart_item_fixture(%{cart_id: cart_id})
    {:ok, cart_item_2} = cart_item_fixture(%{cart_id: cart_id})
    {:ok, cart_item_3} = cart_item_fixture(%{cart_id: cart_id})
    {:ok, cart_item_4} = cart_item_fixture(%{cart_id: cart_id})
    [cart_item_1, cart_item_2, cart_item_3, cart_item_4]
  end

  def discount_fixture(attrs \\ %{}) do
    user_id =
      case attrs[:user_id] do
        nil ->
          {:ok, user} = user_fixture()
          user.id
        user_id ->
          user_id
      end

    cart_id =
      case attrs[:cart_id] do
        nil ->
          {:ok, cart} = cart_fixture(%{user_id: user_id})
          cart.id
        cart_id ->
          cart_id
      end
    
    attrs
    |> Enum.into(%{
      cart_id: cart_id,
      description: attrs[:description] || "Flat Discount",
      flat_discount: attrs[:flat_discount] || valid_flat_discount(),
      percentage_discount: attrs[:percentage_discount] || 0
    })
    |> Sales.create_discount()
  end
end
