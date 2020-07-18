defmodule Db.FeedersTest do
  use Db.DataCase

  alias Db.Feeders

  describe "restaurants" do
    alias Db.Feeders.Restaurant

    @valid_attrs %{address: "some address", name: "some name", url: "some url"}
    @update_attrs %{address: "some updated address", name: "some updated name", url: "some updated url"}
    @invalid_attrs %{address: nil, name: nil, url: nil}

    def restaurant_fixture(attrs \\ %{}) do
      {:ok, restaurant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feeders.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture() |> Repo.preload(:menus)
      assert Feeders.list_restaurants() == [restaurant]
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Feeders.create_restaurant(@valid_attrs)
      assert restaurant.address == "some address"
      assert restaurant.name == "some name"
      assert restaurant.url == "some url"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeders.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{} = restaurant} = Feeders.update_restaurant(restaurant, @update_attrs)
      assert restaurant.address == "some updated address"
      assert restaurant.name == "some updated name"
      assert restaurant.url == "some updated url"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeders.update_restaurant(restaurant, @invalid_attrs)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Feeders.delete_restaurant(restaurant)
      assert {:error, :not_found} = Feeders.get_restaurant(restaurant.id)
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Feeders.change_restaurant(restaurant)
    end
  end

  describe "menus" do
    test "create menu to valid restaurant" do
      restaurant = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu"})
      assert menu.name == "test menu"
    end

    test "create menu with no restaurant_id or name" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeders.create_menu(%{name: "test"})
      assert {:error, %Ecto.Changeset{}} = Feeders.create_menu(%{restaurant_id: restaurant.id})
    end

    test "change order of menu" do
      restaurant = restaurant_fixture()
      # Create some menus, sleep between to simulate order by insertion timestamp
      {:ok, menu1} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
      {:ok, menu2} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu2"})
      {:ok, menu3} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu3"})
      {:ok, menu4} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu4"})

      {:ok, restaurant} = 
        restaurant
        |> Repo.preload(:menus)
        |> Feeders.reset_order_list()

      # First check: Menu 2 should be at the second slot
      assert Enum.at(restaurant.menus_order, 1) == menu2.id

      # Now, insert menu 4 to the second slot
      restaurant = 
        restaurant 
        |> Feeders.change_menu_order(menu4.id, 1, :insert)
        |> update_order

      # Menu 4 should now be at the second slot
      assert Enum.at(restaurant.menus_order, 1) == menu4.id

      # Now, we test methods: [:higher, :lower, :to_bottom, :to_top] after each other
      # We start at (1-4-2-3)
      # We put menu 3 one higher (->1-4-3-2)
      # Then menu 1 one lower (->4-1-3-2)
      # Then 3 to the top (->3-4-1-2)
      # Then 4 to the bottom (->3-1-2-4)
      restaurant = 
        restaurant 
        |> Feeders.change_menu_order(menu3.id, :higher)
        |> update_order
        |> Feeders.change_menu_order(menu1.id, :lower)
        |> update_order
        |> Feeders.change_menu_order(menu3.id, :to_top)
        |> update_order
        |> Feeders.change_menu_order(menu4.id, :to_bottom)
        |> update_order

      # Last check: Menu order should now finally be 3->1->2->4
      assert restaurant.menus_order == [menu3.id, menu1.id, menu2.id, menu4.id]
    end
  end

  defp update_order(changeset) do
    {:ok, restaurant} = Repo.update(changeset)
    restaurant
  end
end
