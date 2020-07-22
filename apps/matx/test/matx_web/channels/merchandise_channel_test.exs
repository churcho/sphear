defmodule MatxWeb.Channels.MerchandiseChannelTest do
  use MatxWeb.ChannelCase

  import Db.AccountsFixtures
  import Db.RestaurantsFixtures
  import Db.MerchandiseFixtures
  alias Bureaucrat.JSON
  alias Db.Feeders
  alias Db.Merchandise
  alias Db.Repo

  setup do
    :ok
  end

  defp guest(_context) do
    {:ok, _, socket} =
      MatxWeb.UserSocket
      |> socket()
      |> subscribe_and_join(MatxWeb.Channels.MerchandiseChannel, "merchandise:lobby")
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
      |> subscribe_and_join(MatxWeb.Channels.MerchandiseChannel, "merchandise:lobby", %{token: token})

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
        |> subscribe_and_join(MatxWeb.Channels.MerchandiseChannel, "merchandise:lobby", %{token: "trololololol"})
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

    test "logged in? as a guest", %{socket: socket} do
      ref = push socket, "logged_in", %{}
      refute_reply ref, :ok, %{user_id: _}
    end

    test "get products from menu", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      create_products(menu)

      menu = Repo.preload(menu, :products)

      products = EctoList.ordered_items_list(menu.products, menu.products_sequence)
      products_json = Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "index.json", products: products)
      data = %{data: products_json}
  
      ref = doc_push(socket, "get_products", %{"menu_id" => menu.id})
      assert_reply(ref, :ok, ^data)
      |> doc()
    end

    test "get non existing products from menu", %{socket: socket} do
      ref = push socket, "get_products", %{"menu_id" => 343}
      assert_reply ref, :error
    end
  end

  describe "user actions -" do
    setup :login

    test "assert user auth channel success", %{user: user} do
      user_id = user.id
      assert_push "lobby", %{login_success: true, user_id: ^user_id}
    end

    test "create a product", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      
      ref = doc_push(socket, "create_product", %{menu_id: menu.id, name: "test product 99", price: 99_00})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_created", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, created_product} = Merchandise.get_product(decoded_data["id"])
      assert created_product.name == "test product 99"
    end

    test "create a non-complete product", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})

      ref = push(socket, "create_product", %{menu_id: menu.id, name: nil, price: 99_00})
      assert_reply ref, :error

      ref = push(socket, "create_product", %{menu_id: nil, name: "test", price: 99_00})
      assert_reply ref, :error

      ref = push(socket, "create_product", %{menu_id: menu.id, name: "test", price: nil})
      assert_reply ref, :error
    end

    test "update a product", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      product = product_fixture(%{menu_id: menu.id})

      params = %{name: "new product name", price: 1337_00}
      ref = doc_push(socket, "update_product", %{product_id: product.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_updated", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, updated_product} = Merchandise.get_product(decoded_data["id"])
      assert updated_product.name == "new product name"
      assert Merchandise.price_to_string(updated_product) == "1.337:-"
    end

    test "delete a product", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      product = product_fixture(%{menu_id: menu.id})

      product_id = product.id

      ref = doc_push(socket, "delete_product", %{product_id: product.id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_deleted", %{message: message, product_id: ^product_id})
      |> doc()

      deleted_product = Merchandise.get_product(product_id)
      assert ^deleted_product = {:error, :not_found}
    end

    test "change sequence of product", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})

      [product1, product2, product3, product4] = create_products(menu)

      {:ok, menu} = 
        menu
        |> Db.Repo.preload(:products)
        |> Merchandise.reset_order_list()

      # First check: Product 2 should be at index 1
      ref = doc_push(socket, "get_products", %{menu_id: menu.id})
      assert_reply(ref, :ok, %{data: data}) |> doc
      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      # assert index 1 == Product 2
      product_slot_1 = Enum.at(decoded_data["products"], 1)
      assert product_slot_1["id"] == product2.id

      # Then, insert product 4 to index 1
      ref = doc_push(socket, "change_product_sequence", %{menu_id: menu.id, product_id: product4.id, action: "insert_at", index: 1})
      assert_reply(ref, :ok, %{data: data}) |> doc
      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      # assert index 1 == Product 4
      product_slot_1 = Enum.at(decoded_data["products"], 1)
      assert product_slot_1["id"] == product4.id

      # Now, we test methods: [:higher, :lower, :to_bottom, :to_top] after each other
      # We start at (1-4-2-3)
      # We put product 3 one higher (->1-4-3-2)
      # Then product 1 one lower (->4-1-3-2)
      # Then 3 to the top (->3-4-1-2)
      # Then 4 to the bottom (->3-1-2-4)
      ref = doc_push(socket, "change_product_sequence", %{menu_id: menu.id, product_id: product3.id, action: "higher"})
      assert_reply(ref, :ok) |> doc
      ref = doc_push(socket, "change_product_sequence", %{menu_id: menu.id, product_id: product1.id, action: "lower"})
      assert_reply(ref, :ok) |> doc
      ref = doc_push(socket, "change_product_sequence", %{menu_id: menu.id, product_id: product3.id, action: "to_top"})
      assert_reply(ref, :ok) |> doc
      ref = doc_push(socket, "change_product_sequence", %{menu_id: menu.id, product_id: product4.id, action: "to_bottom"})
      assert_reply(ref, :ok) |> doc

      # Last check: Product sequence should now finally be ->3-1-2-4
      {:ok, menu} = Feeders.get_menu(menu.id)
      assert menu.products_sequence == [product3.id, product1.id, product2.id, product4.id]
    end
  end

  describe "try to do user actions as a guest -" do
    setup :guest

    test "create a product without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      
      ref = push(socket, "create_product", %{menu_id: menu.id, name: "test product 99", price: 99_00})
      assert_reply ref, :error, %{message: "Unauthorized"}
    end

    test "update a product without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      product = product_fixture(%{menu_id: menu.id})

      params = %{name: "some new name"}
      ref = push(socket, "update_product", %{product_id: product.id, params: params})
      refute_reply(ref, :ok)
      refute_broadcast("product_updated", %{message: _data})
    end

    test "delete a product without logging in", %{socket: socket} do
      restaurant = restaurant_fixture()
      menu = menu_fixture(%{restaurant_id: restaurant.id})
      product = product_fixture(%{menu_id: menu.id})
      product_id = product.id

      ref = push(socket, "delete_product", %{product_id: product.id})
      refute_reply(ref, :ok)
      refute_broadcast("product_deleted", %{message: _message, product_id: ^product_id})
    end
  end
end
