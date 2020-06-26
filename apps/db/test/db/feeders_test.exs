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
      restaurant = restaurant_fixture()
      assert Feeders.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Feeders.get_restaurant!(restaurant.id) == restaurant
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
      assert restaurant == Feeders.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Feeders.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Feeders.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Feeders.change_restaurant(restaurant)
    end
  end
end
