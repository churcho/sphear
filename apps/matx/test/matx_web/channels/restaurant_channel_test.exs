defmodule MatxWeb.RestaurantChannelTest do
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
      |> subscribe_and_join(MatxWeb.RestaurantChannel, "restaurants:lobby")
    %{socket: socket}
  end

  defp login(_context) do
    # Create user
    user = user_fixture()
    conn = Phoenix.ConnTest.build_conn()
    # Login with the user credentials
    conn =
      post(conn, Routes.api_user_session_path(conn, :create), %{
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
      |> subscribe_and_join(MatxWeb.RestaurantChannel, "restaurants:lobby", %{token: token})

    %{user: user, socket: socket}
  end

  describe "guest actions" do
    setup :guest

    test "assert successfully joined channel as a guest", %{socket: _socket} do
      assert_push "lobby", %{guest_success: true}
    end

    test "try to auth with a invalid token", %{socket: _socket} do
      {status, _reason} =
        MatxWeb.UserSocket
        |> socket()
        |> subscribe_and_join(MatxWeb.RestaurantChannel, "restaurants:lobby", %{token: "trololololol"})
      assert ^status = :error
    end

    test "ping pong", %{socket: socket} do
      ref = push socket, "ping", %{}
      assert_reply ref, :ok, %{message: "pong"}
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
  
      ref = push socket, "get", %{"id" => "all"}
      assert_reply ref, :ok, ^data
    end

    test "get one restaurant", %{socket: socket} do
      restaurant_fixture()
      restaurant = restaurant_fixture()
      restaurant_json = Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)
      data = %{data: restaurant_json}
  
      ref = push socket, "get", %{"id" => restaurant.id}
      assert_reply ref, :ok, ^data
    end

    test "get non existing restaurant", %{socket: socket} do
      ref = push socket, "get", %{"id" => 343}
      assert_reply ref, :error, %{data: "Could not find restaurant"}
    end

    test "logged in? as a guest", %{socket: socket} do
      ref = push socket, "logged_in", %{}
      refute_reply ref, :ok, %{user_id: _}
    end
  end

  describe "user actions" do
    setup :login

    test "assert user auth channel success", %{user: user} do
      user_id = user.id
      assert_push "lobby", %{login_success: true, user_id: ^user_id}
    end

    test "logged in? while logged in", %{socket: socket, user: user} do
      ref = push socket, "logged_in", %{}
      user_id = user.id
      assert_reply ref, :ok, %{user_id: ^user_id}
    end

    test "create a restaurant while logged in", %{socket: socket} do
      ref = push socket, "create", %{name: "test", url: "some url", address: "some address"}
      assert_reply ref, :ok
      assert_broadcast "restaurant_created", %{data: data}
    end

    test "create a non-complete restaurant", %{socket: socket} do
      ref = push socket, "create", %{name: "test"}
      assert_reply ref, :error
    end
  end

  describe "try to do user actions as a guest" do
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
  end
end
