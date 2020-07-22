defmodule Db.MerchandiseTest do
  use Db.DataCase

  import Db.MerchandiseFixtures
  alias Db.Merchandise

  describe "products" do
    alias Db.Merchandise.Product

    @update_attrs %{name: "an updated product name", price: 99_00}
    @invalid_attrs %{name: nil, price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Merchandise.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Merchandise.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      product = product_fixture()
      assert Merchandise.price_to_string(product) == "1.337:-"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Merchandise.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Merchandise.update_product(product, @update_attrs)
      assert product.name == "an updated product name"
      assert Merchandise.price_to_string(product) == "99:-"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Merchandise.update_product(product, @invalid_attrs)
      assert product == Merchandise.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Merchandise.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Merchandise.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Merchandise.change_product(product)
    end
  end
end
