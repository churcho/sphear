defmodule Db.BookingsTest do
  use Db.DataCase

  alias Db.Bookings

  describe "categories" do
    alias Db.Bookings.Category

    @valid_attrs %{description: "some description", image: "some image", name: "some name"}
    @update_attrs %{description: "some updated description", image: "some updated image", name: "some updated name"}
    @invalid_attrs %{description: nil, image: nil, name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bookings.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Bookings.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Bookings.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Bookings.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.image == "some image"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Bookings.update_category(category, @update_attrs)
      assert category.description == "some updated description"
      assert category.image == "some updated image"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookings.update_category(category, @invalid_attrs)
      assert category == Bookings.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Bookings.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Bookings.change_category(category)
    end
  end

  describe "missions" do
    alias Db.Bookings.Mission

    @valid_attrs %{ends_at: "2010-04-17T14:00:00Z", starts_at: "2010-04-17T14:00:00Z", status: "some status"}
    @update_attrs %{ends_at: "2011-05-18T15:01:01Z", starts_at: "2011-05-18T15:01:01Z", status: "some updated status"}
    @invalid_attrs %{ends_at: nil, starts_at: nil, status: nil}

    def mission_fixture(attrs \\ %{}) do
      {:ok, mission} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bookings.create_mission()

      mission
    end

    test "list_missions/0 returns all missions" do
      mission = mission_fixture()
      assert Bookings.list_missions() == [mission]
    end

    test "get_mission!/1 returns the mission with given id" do
      mission = mission_fixture()
      assert Bookings.get_mission!(mission.id) == mission
    end

    test "create_mission/1 with valid data creates a mission" do
      assert {:ok, %Mission{} = mission} = Bookings.create_mission(@valid_attrs)
      assert mission.ends_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert mission.starts_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert mission.status == "some status"
    end

    test "create_mission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_mission(@invalid_attrs)
    end

    test "update_mission/2 with valid data updates the mission" do
      mission = mission_fixture()
      assert {:ok, %Mission{} = mission} = Bookings.update_mission(mission, @update_attrs)
      assert mission.ends_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert mission.starts_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert mission.status == "some updated status"
    end

    test "update_mission/2 with invalid data returns error changeset" do
      mission = mission_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookings.update_mission(mission, @invalid_attrs)
      assert mission == Bookings.get_mission!(mission.id)
    end

    test "delete_mission/1 deletes the mission" do
      mission = mission_fixture()
      assert {:ok, %Mission{}} = Bookings.delete_mission(mission)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_mission!(mission.id) end
    end

    test "change_mission/1 returns a mission changeset" do
      mission = mission_fixture()
      assert %Ecto.Changeset{} = Bookings.change_mission(mission)
    end
  end

  describe "demo" do
    alias Db.Bookings.Demo

    @valid_attrs %{email: "some email", message: "some message", name: "some name", phone: "some phone"}
    @update_attrs %{email: "some updated email", message: "some updated message", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{email: nil, message: nil, name: nil, phone: nil}

    def demo_fixture(attrs \\ %{}) do
      {:ok, demo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bookings.create_demo()

      demo
    end

    test "list_demo/0 returns all demo" do
      demo = demo_fixture()
      assert Bookings.list_demo() == [demo]
    end

    test "get_demo!/1 returns the demo with given id" do
      demo = demo_fixture()
      assert Bookings.get_demo!(demo.id) == demo
    end

    test "create_demo/1 with valid data creates a demo" do
      assert {:ok, %Demo{} = demo} = Bookings.create_demo(@valid_attrs)
      assert demo.email == "some email"
      assert demo.message == "some message"
      assert demo.name == "some name"
      assert demo.phone == "some phone"
    end

    test "create_demo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_demo(@invalid_attrs)
    end

    test "update_demo/2 with valid data updates the demo" do
      demo = demo_fixture()
      assert {:ok, %Demo{} = demo} = Bookings.update_demo(demo, @update_attrs)
      assert demo.email == "some updated email"
      assert demo.message == "some updated message"
      assert demo.name == "some updated name"
      assert demo.phone == "some updated phone"
    end

    test "update_demo/2 with invalid data returns error changeset" do
      demo = demo_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookings.update_demo(demo, @invalid_attrs)
      assert demo == Bookings.get_demo!(demo.id)
    end

    test "delete_demo/1 deletes the demo" do
      demo = demo_fixture()
      assert {:ok, %Demo{}} = Bookings.delete_demo(demo)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_demo!(demo.id) end
    end

    test "change_demo/1 returns a demo changeset" do
      demo = demo_fixture()
      assert %Ecto.Changeset{} = Bookings.change_demo(demo)
    end
  end
end
