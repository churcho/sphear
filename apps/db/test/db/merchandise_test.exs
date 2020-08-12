defmodule Db.MerchandiseTest do
  use Db.DataCase

  import Db.MerchandiseFixtures
  import Db.RestaurantsFixtures
  alias Db.Merchandise
  alias Db.Feeders.Menu

  describe "products" do
    alias Db.Merchandise.{Product, ProductExtra, ProductExtraMenu}

    @update_attrs %{name: "an updated product name", price: 99_00}
    @invalid_attrs %{name: nil, price: nil}

    test "list_products/0 returns all products" do
      {:ok, product} = product_fixture()
      assert Merchandise.list_products() == [product]
    end

    test "create_product/1 with valid data creates a product" do
      {:ok, product} = product_fixture(%{price: 133700})
      assert Merchandise.price_to_string(product.price) == "1.337:-"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Merchandise.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      {:ok, product} = product_fixture()
      assert {:ok, %Product{} = product} = Merchandise.update_product(product, @update_attrs)
      assert product.name == "an updated product name"
      assert Merchandise.price_to_string(product.price) == "99:-"
    end

    test "update_product/2 with invalid data returns error changeset" do
      {:ok, product} = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Merchandise.update_product(product, @invalid_attrs)
    end

    test "delete_product/1 deletes the product" do
      {:ok, product} = product_fixture()
      assert {:ok, %Product{}} = Merchandise.delete_product(product)
    end

    test "change_product/1 returns a product changeset" do
      {:ok, product} = product_fixture()
      assert %Ecto.Changeset{} = Merchandise.change_product(product)
    end

    test "change_product_extra_menu/1 returns a product extra menu changeset" do
      {:ok, product_extra_menu} = product_extra_menu_fixture()
      # Returns changeset correctly
      assert %Ecto.Changeset{} = Merchandise.change_product_extra_menu(product_extra_menu)
    end

    test "change_product_extra/1 returns a product extra changeset" do
      {:ok, product_extra} = product_extra_fixture()
      # Returns changeset correctly
      assert %Ecto.Changeset{} = Merchandise.change_product_extra(product_extra)
    end

    test "product extra menu" do
      # Try but fail to create a product extra menu with a nonexisting product_id
      assert {:error, %Ecto.Changeset{}} = product_extra_menu_fixture(%{product_id: 133337})
      
      # Create a product
      {:ok, product} = product_fixture()
      # Create a extra menu for the product
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{name: "Sauces", product_id: product.id})

      # Check default values
      assert product_extra_menu.name == "Sauces"
      assert product_extra_menu.mandatory == false
      assert product_extra_menu.pick_only_one == false

      # Update the menu
      changes = %{mandatory: true, pick_only_one: true, name: "Must Pick One Sauce"}
      assert {:ok, %ProductExtraMenu{} = updated_product_extra_menu} = Merchandise.update_product_extra_menu(product_extra_menu, changes)
      assert updated_product_extra_menu.name == "Must Pick One Sauce"
      assert updated_product_extra_menu.mandatory == true
      assert updated_product_extra_menu.pick_only_one == true

      # Delete the menu
      assert {:ok, %ProductExtraMenu{}} = Merchandise.delete_product_extra_menu(product_extra_menu)
  
      # Create a product extra menu for a menu
      {:ok, menu} = menu_fixture()
      assert {:ok, product_extra_menu} = product_extra_menu_fixture(%{menu_id: menu.id})
      
      # Error when providing both menu and product
      assert {:error, %Ecto.Changeset{}} = product_extra_menu_fixture(%{menu_id: menu.id, product_id: product.id})
    end

    test "product extra" do
      # Try but fail to create a product extra with a nonexisting product_extra_menu_id
      assert {:error, %Ecto.Changeset{}} = product_extra_menu_fixture(%{product_id: 133337})

      # Create a product
      {:ok, product} = product_fixture()
      # Create a extra menu for the product
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{name: "Sauces", product_id: product.id})
      # Create a product extra to the product extra menu
      assert {:ok, %ProductExtra{} = product_extra} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id})
    
      # Create a product extra without a product to override
      assert {:ok, product_extra} = Merchandise.create_product_extra(%{product_extra_menu_id: product_extra_menu.id, new_name: "Tabasco", new_price: 10_00})
      assert product_extra.product == nil
    end
  end
end
