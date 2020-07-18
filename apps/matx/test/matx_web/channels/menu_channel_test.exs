defmodule MatxWeb.Channels.MenuChannelTest do
  use MatxWeb.ChannelCase

  import Db.AccountsFixtures
  import Db.RestaurantsFixtures
  alias Db.Feeders
  alias Bureaucrat.JSON

  setup do
    restaurant_fixture()
    :ok
  end

  defp guest(_context) do
    {:ok, _, socket} =
      MatxWeb.UserSocket
      |> socket()
      |> subscribe_and_join(MatxWeb.Channels.MenuChannel, "menus:lobby")
      %{socket: socket}
  end

  defp login(_context) do
    # Create user
    user = user_fixture()
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
      |> subscribe_and_join(MatxWeb.Channels.MenuChannel, "menus:lobby", %{token: token})

    %{user: user, socket: socket}
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
        |> subscribe_and_join(MatxWeb.Channels.MenuChannel, "menus:lobby", %{token: "trololololol"})
      assert ^status = :error
    end

    test "ping", %{socket: socket} do
      ref = doc_push socket, "ping", %{}
      assert_reply(ref, :ok, %{message: "pong"})
      |> doc()
    end

    test "close socket", %{socket: socket} do
      Process.monitor(socket.channel_pid)
      send(socket.channel_pid, :ping)
      refute_receive {:DOWN, _, _, _, :normal}

      push socket, "goodbye", %{}
      
      send(socket.channel_pid, :ping)
      assert_receive {:DOWN, _, _, _, :normal}
    end

    test "get all menus from a restaurant", %{socket: socket} do
      restaurant = restaurant_fixture()
      Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
      Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu2"})
      Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu3"})

      restaurant = Db.Repo.preload(restaurant, :menus)
      menus = EctoList.ordered_items_list(restaurant.menus, restaurant.menus_order)
      menus_json = Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "index.json", menus: menus)
      data = %{data: menus_json}
  
      ref = doc_push(socket, "get", %{"restaurant_id" => restaurant.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get one menu", %{socket: socket} do
      restaurant = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
      
      menu_json = Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)
      data = %{data: menu_json}
  
      ref = doc_push(socket, "get", %{"menu_id" => menu.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get non existing menu", %{socket: socket} do
      ref = push socket, "get", %{"menu_id" => 343}
      assert_reply ref, :error
    end

    test "get non existing restaurant", %{socket: socket} do
      ref = push socket, "get", %{"restaurant_id" => 343}
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

    test "ensure logged in correctly", %{socket: socket, user: user} do
      ref = doc_push(socket, "logged_in", %{})
      user_id = user.id
      assert_reply(ref, :ok, %{user_id: ^user_id})
      |> doc()
    end

    test "create a menu", %{socket: socket} do
      restaurant = restaurant_fixture()
      ref = doc_push(socket, "create", %{restaurant_id: restaurant.id, name: "test menu"})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("menu_created", %{data: data})
      |> doc()
    end

    test "create a non-complete menu", %{socket: socket} do
      # No restaurant id
      ref = push socket, "create", %{name: "test"}
      assert_reply ref, :error

      restaurant = restaurant_fixture()

      # No name
      ref = push socket, "create", %{restaurant_id: restaurant.id}
      assert_reply ref, :error

      # Random restaurant id
      ref = push socket, "create", %{restaurant_id: 2323}
      assert_reply ref, :error
    end

    test "edit a menu", %{socket: socket} do
      restaurant = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})

      params = %{name: "some new name"}
      ref = doc_push(socket, "update", %{id: menu.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("menu_updated", %{data: data})
      |> doc()
    end

    test "delete a menu", %{socket: socket} do
      restaurant = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
      menu_id = menu.id

      ref = doc_push(socket, "delete", %{id: menu_id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("menu_deleted", %{message: message, id: ^menu_id})
      |> doc()
    end

    test "change order of menu", %{socket: socket} do
      restaurant = restaurant_fixture()
      # Create some menus, sleep between to simulate order by insertion timestamp
      {:ok, menu1} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})
      {:ok, menu2} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu2"})
      {:ok, menu3} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu3"})
      {:ok, menu4} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu4"})

      {:ok, restaurant} = 
        restaurant
        |> Db.Repo.preload(:menus)
        |> Feeders.reset_order_list()

      # First check: Menu 1 should be at slot 0
      ref = doc_push(socket, "get", %{restaurant_id: restaurant.id})
      assert_reply(ref, :ok, %{data: data}) |> doc
      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      # assert Slot 0 == Menu 1
      menu_slot_0 = Enum.at(decoded_data["menus"], 0)
      assert menu_slot_0["id"] == menu1.id

      # Insert menu4 to second slot
      ref = doc_push(socket, "change_menu_order", %{restaurant_id: restaurant.id, menu_id: menu4.id, action: "insert_at_index", index: 0})
      assert_reply(ref, :ok, %{data: data}) |> doc
      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      # assert Slot 0 == Menu 4
      menu_slot_1 = Enum.at(decoded_data["menus"], 0)
      assert menu_slot_1["id"] == menu4.id

      # Push menu3 higher
      ref = doc_push(socket, "change_menu_order", %{restaurant_id: restaurant.id, menu_id: menu3.id, action: "higher"})
      assert_reply(ref, :ok) |> doc
      
      # Push menu1 lower
      ref = doc_push(socket, "change_menu_order", %{restaurant_id: restaurant.id, menu_id: menu1.id, action: "lower"})
      assert_reply(ref, :ok) |> doc
      
      # Push menu3 to the top
      ref = doc_push(socket, "change_menu_order", %{restaurant_id: restaurant.id, menu_id: menu3.id, action: "to_top"})
      assert_reply(ref, :ok) |> doc
      
      # Push menu2 to the bottom
      ref = doc_push(socket, "change_menu_order", %{restaurant_id: restaurant.id, menu_id: menu2.id, action: "to_bottom"})
      assert_reply(ref, :ok) |> doc
    end
  end

  describe "try to do user actions as a guest -" do
    setup :guest

    test "create a menu without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()

      ref = push(socket, "create", %{restaurant_id: restaurant.id, name: "test menu"})
      assert_reply ref, :error, %{message: "Unauthorized"}
    end

    test "edit a menu without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant.id, name: "test menu1"})

      params = %{name: "some new name"}
      ref = push(socket, "update", %{id: menu.id, params: params})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_updated", %{message: _data})
    end

    test "delete a menu without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      restaurant_id = restaurant.id
      {:ok, menu} = Feeders.create_menu(%{restaurant_id: restaurant_id, name: "test menu1"})

      ref = push(socket, "delete", %{id: menu.id})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_deleted", %{message: _message, id: ^restaurant_id})
    end
  end
end
