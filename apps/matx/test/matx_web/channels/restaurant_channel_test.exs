defmodule MatxWeb.Channels.RestaurantChannelTest do
  use MatxWeb.ChannelCase

  import Db.AccountsFixtures
  import Db.RestaurantsFixtures
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
      |> subscribe_and_join(MatxWeb.Channels.RestaurantChannel, "restaurants:lobby", %{token: token})

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
        |> subscribe_and_join(MatxWeb.Channels.RestaurantChannel, "restaurants:lobby", %{token: "trololololol"})
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

    test "get all restaurants", %{socket: socket} do
      restaurant_fixture()
      restaurant_fixture()
  
      restaurants = Feeders.list_restaurants
      restaurants_json = Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "index.json", restaurants: restaurants)
      data = %{data: restaurants_json}
  
      ref = doc_push(socket, "get", %{"id" => "all"})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get one restaurant", %{socket: socket} do
      restaurant_fixture()
      restaurant = restaurant_fixture()
      restaurant_json = Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)
      data = %{data: restaurant_json}
  
      ref = doc_push(socket, "get", %{"id" => restaurant.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get non existing restaurant", %{socket: socket} do
      ref = push socket, "get", %{"id" => 343}
      assert_reply ref, :error, %{message: "Could not find restaurant"}
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

    test "create a restaurant", %{socket: socket} do
      ref = doc_push(socket, "create", %{name: "test", url: "some url", address: "some address"})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("restaurant_created", %{data: data})
      |> doc()
    end

    test "create a non-complete restaurant", %{socket: socket} do
      ref = push socket, "create", %{name: "test"}
      assert_reply ref, :error
    end

    test "edit a restaurant", %{socket: socket} do
      restaurant = restaurant_fixture()
      params = %{name: "new name", url: "new url"}
      ref = doc_push(socket, "update", %{id: restaurant.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("restaurant_updated", %{data: data})
      |> doc()
    end

    test "delete a restaurant", %{socket: socket} do
      restaurant = restaurant_fixture()
      restaurant_id = restaurant.id
      ref = doc_push(socket, "delete", %{id: restaurant.id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("restaurant_deleted", %{message: message, id: ^restaurant_id})
      |> doc()
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
      ref = push socket, "create", restaurant_params
      assert_reply ref, :error, %{message: "Unauthorized"}
    end

    test "edit a restaurant without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      params = %{name: "new name", url: "new url"}
      ref = push(socket, "update", %{id: restaurant.id, params: params})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_updated", %{message: _data})
    end

    test "delete a restaurant without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      restaurant_id = restaurant.id
      ref = push(socket, "delete", %{id: restaurant.id})
      refute_reply(ref, :ok)
      refute_broadcast("restaurant_deleted", %{message: _message, id: ^restaurant_id})
    end
  end
end
