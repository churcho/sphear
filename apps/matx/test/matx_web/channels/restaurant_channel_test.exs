defmodule MatxWeb.Channels.RestaurantChannelTest do
  use MatxWeb.ChannelCase

  import Db.AccountsFixtures
  import Db.RestaurantsFixtures
  import Db.MerchandiseFixtures
  alias Bureaucrat.JSON
  alias Db.Feeders

  setup do
    restaurant_fixture()
    :ok
  end

  defp guest(_context) do
    {:ok, _, socket} =
      MatxWeb.UserSocket
      |> socket()
      |> subscribe_and_join(MatxWeb.Channels.RestaurantChannel, "restaurants:lobby")
      %{socket: socket}
  end

  defp login(_context) do
    # Create user
    {:ok, user} = user_fixture()
    conn = Phoenix.ConnTest.build_conn()
    # Login with the user credentials
    conn =
      post(conn, ApiRoutes.api_user_session_path(conn, :create), %{
        "email" => user.email,
        "password" => valid_user_password()
      })
    # Grab the token
    response = json_response(conn, 200)
    token = response["success"]["token"]
    # Authenticate channel with the token
    {:ok, _, socket} =
      MatxWeb.UserSocket
      |> socket()
      |> subscribe_and_join(MatxWeb.Channels.RestaurantChannel, "restaurants:lobby", %{token: token})

    %{user: user, socket: socket}
  end

  describe "test actions -" do
    setup :guest

    test "ping", %{socket: socket} do
      ref = doc_push socket, "ping", %{}
      assert_reply(ref, :ok, %{message: "pong"})
      |> doc()
    end

    setup :login
    
    test "ensure logged in correctly", %{socket: socket, user: user} do
      ref = doc_push(socket, "logged_in", %{})
      user_id = user.id
      assert_reply(ref, :ok, %{user_id: ^user_id})
      |> doc()
    end
  end

  describe "guest actions -" do
    setup :guest

    test "assert successfully joined channel as a guest", %{socket: _socket} do
      assert_push("lobby", %{guest_success: true})
    end

    test "try to auth with a invalid token", %{socket: _socket} do
      {status, _reason} =
        MatxWeb.UserSocket
        |> socket()
        |> subscribe_and_join(MatxWeb.Channels.RestaurantChannel, "restaurants:lobby", %{token: "trololololol"})
      assert ^status = :error
    end

    test "close socket", %{socket: socket} do
      Process.monitor(socket.channel_pid)
      send(socket.channel_pid, :ping)
      refute_receive {:DOWN, _, _, _, :normal}

      push socket, "goodbye", %{}
      
      send(socket.channel_pid, :ping)
      assert_receive {:DOWN, _, _, _, :normal}
    end

    test "get all restaurants", %{socket: socket} do
      restaurant_fixture()
      restaurant_fixture()
  
      restaurants = Feeders.list_restaurants
      restaurants_json = Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "index.json", restaurants: restaurants)
      data = %{data: restaurants_json}
  
      ref = doc_push(socket, "get_restaurants")
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get one restaurant", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      restaurant_id = restaurant.id

      {:ok, menu} = menu_fixture(restaurant_id: restaurant_id)
      [product1, _, _, _] = create_products(menu)

      {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product1.id})
      create_pommes_extras(restaurant_id, product_extra_menu.id)

      {:ok, restaurant} = 
        Feeders.get_restaurant(restaurant.id)
      {:ok, restaurant} =
        restaurant
        |> Feeders.reset_order_list()

      restaurant_json = Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)
      data = %{data: restaurant_json}
  
      ref = doc_push(socket, "get_restaurant", %{"restaurant_id" => restaurant.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get non existing restaurant", %{socket: socket} do
      ref = push socket, "get_restaurant", %{"restaurant_id" => 343}
      assert_reply ref, :error, %{message: "Could not find restaurant"}
    end

    test "get all menus from a restaurant", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      create_menus(restaurant)

      {:ok, restaurant} = 
        Feeders.get_restaurant(restaurant.id)
      {:ok, restaurant}
        restaurant
        |> Feeders.reset_order_list()

      menus = EctoList.ordered_items_list(restaurant.menus, restaurant.menus_sequence)
      menus_json = Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "index.json", menus: menus)
      data = %{data: menus_json}
  
      ref = doc_push(socket, "get_menus", %{"restaurant_id" => restaurant.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get one menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      
      menu_json = Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)
      data = %{data: menu_json}
  
      ref = doc_push(socket, "get_menu", %{"menu_id" => menu.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get non existing menu", %{socket: socket} do
      ref = push socket, "get_menu", %{"menu_id" => 343}
      assert_reply ref, :error
    end

    test "logged in? as a guest", %{socket: socket} do
      ref = push socket, "logged_in", %{}
      refute_reply ref, :ok, %{user_id: _}
    end
  end

  describe "user actions -" do
    setup :login

    test "assert user auth channel success", %{user: user} do
      user_id = user.id
      assert_push "lobby", %{login_success: true, user_id: ^user_id}
    end

    test "create a restaurant", %{socket: socket} do
      ref = doc_push(socket, "create_restaurant", %{name: "test", url: "some url", address: "some address"})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("restaurant_created", %{data: data})
      |> doc()
    end

    test "create a non-complete restaurant", %{socket: socket} do
      ref = push socket, "create_restaurant", %{name: "test"}
      assert_reply ref, :error

      ref = push socket, "create_restaurant", %{url: "test"}
      assert_reply ref, :error

      ref = push socket, "create_restaurant", %{address: "test"}
      assert_reply ref, :error
    end

    test "update a restaurant", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      params = %{name: "new name", url: "new url"}
      ref = doc_push(socket, "update_restaurant", %{restaurant_id: restaurant.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("restaurant_updated", %{data: data})
      |> doc()
    end

    test "delete a restaurant", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      restaurant_id = restaurant.id
      ref = doc_push(socket, "delete_restaurant", %{restaurant_id: restaurant.id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("restaurant_deleted", %{message: message, restaurant_id: ^restaurant_id})
      |> doc()
    end

    test "create a menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      ref = doc_push(socket, "create_menu", %{restaurant_id: restaurant.id, name: "test menu"})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("menu_created", %{data: data})
      |> doc()
    end

    test "create a non-complete menu", %{socket: socket} do
      # No restaurant id
      ref = push socket, "create_menu", %{name: "test"}
      assert_reply ref, :error

      # Random restaurant id
      ref = push socket, "create_menu", %{restaurant_id: 2323}
      assert_reply ref, :error

      {:ok, restaurant} = restaurant_fixture()

      # Correct restaurant id, but missing name param
      ref = push socket, "create_menu", %{restaurant_id: restaurant.id}
      assert_reply ref, :error
    end

    test "update a menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})

      params = %{name: "some new name"}
      ref = doc_push(socket, "update_menu", %{menu_id: menu.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("menu_updated", %{data: data})
      |> doc()
    end

    test "delete a menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
      menu_id = menu.id

      ref = doc_push(socket, "delete_menu", %{menu_id: menu_id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("menu_deleted", %{message: message, menu_id: ^menu_id})
      |> doc()
    end

    test "change sequence of menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      [menu1, menu2, menu3, menu4] = create_menus(restaurant)

      {:ok, restaurant} = 
        Feeders.get_restaurant(restaurant.id)
      {:ok, restaurant} =
        restaurant
        |> Feeders.reset_order_list()

      # First check: Menu 2 should be at index 1
      ref = doc_push(socket, "get_restaurant", %{restaurant_id: restaurant.id})
      assert_reply(ref, :ok, %{data: data}) |> doc
      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      # assert index 1 == Menu 2
      menu_slot_1 = Enum.at(decoded_data["menus"], 1)
      assert menu_slot_1["id"] == menu2.id

      # Then, insert menu 4 to index 1
      ref = doc_push(socket, "change_menu_sequence", %{restaurant_id: restaurant.id, menu_id: menu4.id, action: "insert_at", index: 1})
      assert_reply(ref, :ok, %{data: data}) |> doc
      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      # assert index 1 == Menu 4
      menu_slot_1 = Enum.at(decoded_data["menus"], 1)
      assert menu_slot_1["id"] == menu4.id

      # Now, we test methods: [:higher, :lower, :to_bottom, :to_top] after each other
      # We start at (1-4-2-3)
      # We put menu 3 one higher (->1-4-3-2)
      # Then menu 1 one lower (->4-1-3-2)
      # Then 3 to the top (->3-4-1-2)
      # Then 4 to the bottom (->3-1-2-4)
      ref = doc_push(socket, "change_menu_sequence", %{restaurant_id: restaurant.id, menu_id: menu3.id, action: "higher"})
      assert_reply(ref, :ok) |> doc
      ref = doc_push(socket, "change_menu_sequence", %{restaurant_id: restaurant.id, menu_id: menu1.id, action: "lower"})
      assert_reply(ref, :ok) |> doc
      ref = doc_push(socket, "change_menu_sequence", %{restaurant_id: restaurant.id, menu_id: menu3.id, action: "to_top"})
      assert_reply(ref, :ok) |> doc
      ref = doc_push(socket, "change_menu_sequence", %{restaurant_id: restaurant.id, menu_id: menu4.id, action: "to_bottom"})
      assert_reply(ref, :ok) |> doc

      # Last check: Menu sequence should now finally be ->3-1-2-4
      {:ok, restaurant} = Feeders.get_restaurant(restaurant.id)
      assert restaurant.menus_sequence == [menu3.id, menu1.id, menu2.id, menu4.id]
    end
  end

  describe "try to do user actions as a guest -" do
    setup :guest

    test "create a restaurant without logging in", %{socket: socket} do
      restaurant_params = %{
        "name" => "name23",
        "url" => "url23",
        "address" => "address23"
      }
      ref = push socket, "create_restaurant", restaurant_params
      assert_reply ref, :error, %{message: "Unauthorized"}
    end

    test "edit a restaurant without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      params = %{name: "new name", url: "new url"}
      ref = push(socket, "update_restaurant", %{restaurant_id: restaurant.id, params: params})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_updated", %{message: _data})
    end

    test "delete a restaurant without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      restaurant_id = restaurant.id
      ref = push(socket, "delete_restaurant", %{restaurant_id: restaurant.id})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_deleted", %{message: _message, restaurant_id: ^restaurant_id})
    end

    test "create a menu without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()

      ref = push(socket, "create_menu", %{restaurant_id: restaurant.id, name: "test menu"})
      assert_reply ref, :error, %{message: "Unauthorized"}
    end

    test "update a menu without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})

      params = %{name: "some new name"}
      ref = push(socket, "update_menu", %{menu_id: menu.id, params: params})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_updated", %{message: _data})
    end

    test "delete a menu without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      restaurant_id = restaurant.id
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant_id, name: "test menu1"})

      ref = push(socket, "delete_menu", %{menu_id: menu.id})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_deleted", %{message: _message, menu_id: ^restaurant_id})
    end
  end
end
