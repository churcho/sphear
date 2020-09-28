defmodule Db.SalesTest do
  use Db.DataCase

  import Db.SalesFixtures
  import Db.AccountsFixtures
  import Db.MerchandiseFixtures
  alias Db.Accounts
  alias Db.Sales
  alias Db.Merchandise.{Product, ProductExtra, ProductExtraMenu}
  alias Db.Sales.{Cart, CartItem, Discount, Order}

  describe "carts" do
    test "create cart" do
      {:ok, user} = user_fixture()
      assert {:ok, cart} = cart_fixture(user_id: user.id)
      assert cart.user_id == user.id
    end

    test "get cart" do
      {:ok, cart} = cart_fixture()
      assert {:ok, cart} = Sales.get_cart(cart.id)
    end

    test "get latest cart" do
      {:ok, user} = user_fixture()
      cart_fixture(user_id: user.id)
      Process.sleep(500)
      cart_fixture(user_id: user.id)
      Process.sleep(500)
      {:ok, latest_cart} = cart_fixture(user_id: user.id)
      assert Sales.get_latest_cart(user.id) == latest_cart
    end
  end

  describe "cart items" do
    test "create cart item" do
      assert {:ok, cart_item} = cart_item_fixture()
      
      {:ok, cart} = cart_fixture()
      {:ok, product} = product_fixture()
      {:ok, product_extra} = product_extra_fixture()

      # Cart item with product
      assert {:ok, cart_item} = Sales.create_cart_item(%{cart_id: cart.id, product_id: product.id})
      # Cart item with product extra
      assert {:ok, cart_item} = Sales.create_cart_item(%{cart_id: cart.id, product_extra_id: product_extra.id})
    
      # Cart item with both product and product_extra == error
      assert {:error, %Ecto.Changeset{}} = Sales.create_cart_item(%{cart_id: cart.id, product_id: product.id, product_extra_id: product_extra.id})
    end
  end

  describe "discounts" do
    test "create discount" do
      assert {:ok, discount} = discount_fixture()
    end
  end

  describe "orders" do
    test "create order" do
      {:ok, order} = order_fixture()
    end
  end
end
