defmodule Db.SalesTest do
  use Db.DataCase

  import Db.SalesFixtures
  import Db.AccountsFixtures
  alias Db.Accounts
  alias Db.Sales
  alias Db.Merchandise.{Product, ProductExtra, ProductExtraMenu}
  alias Db.Sales.{Cart, CartItem, Discount, Order}

  describe "cart" do
    test "create cart" do
      {:ok, user} = user_fixture()
      assert {:ok, cart} = cart_fixture(user_id: user.id)
    end

    test "get cart" do
      {:ok, cart} = cart_fixture()
      assert {:ok, cart} = Sales.get_cart(cart.id)
    end

    test "get latest cart" do
      {:ok, user} = user_fixture()
      cart_fixture(user_id: user.id)
      cart_fixture(user_id: user.id)
      {:ok, latest_cart} = cart_fixture(user_id: user.id)
      
      {:ok, user} = Accounts.get_user(user.id)
      assert Sales.get_latest_cart(user.id) == latest_cart
    end

    
  end
end
