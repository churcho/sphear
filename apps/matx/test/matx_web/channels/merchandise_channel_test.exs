defmodule MatxWeb.Channels.MerchandiseChannelTest do
  use MatxWeb.ChannelCase

  import Db.AccountsFixtures
  import Db.RestaurantsFixtures
  import Db.MerchandiseFixtures
  alias Bureaucrat.JSON
  alias Db.Feeders
  alias Db.Merchandise
  alias Db.Repo
  alias Db.Feeders.Menu

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
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      create_products(menu)

      {:ok, menu} =
        Repo.get(Menu, menu.id) 
        |> Repo.preload([products: [product_extra_menus: [product_extras: :product]]])
        |> Merchandise.reset_order_list()

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
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      
      ref = doc_push(socket, "create_product", %{menu_id: menu.id, name: "test product 99", price: 99_00, hidden: false})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_created", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, created_product} = Merchandise.get_product(decoded_data["id"])
      assert created_product.name == "test product 99"
    end

    test "create a unlisted product", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      
      ref = doc_push(socket, "create_unlisted_product", %{restaurant_id: restaurant.id, name: "test product 29", price: 29_00, hidden: true})
      assert_reply(ref, :ok, %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, created_product} = Merchandise.get_product(decoded_data["id"])
      assert created_product.name == "test product 29"
    end

    test "create a non-complete product", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})

      ref = push(socket, "create_product", %{menu_id: menu.id, name: nil, price: 99_00})
      assert_reply ref, :error

      ref = push(socket, "create_product", %{menu_id: nil, name: "test", price: 99_00})
      assert_reply ref, :error

      ref = push(socket, "create_product", %{menu_id: menu.id, name: "test", price: nil})
      assert_reply ref, :error
    end

    test "update a product", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})

      params = %{name: "new product name", price: 1337_00}
      ref = doc_push(socket, "update_product", %{product_id: product.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_updated", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, updated_product} = Merchandise.get_product(decoded_data["id"])
      assert updated_product.name == "new product name"
      assert Merchandise.price_to_string(updated_product.price) == "1.337:-"
    end

    test "delete a product", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})

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
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})

      [product1, product2, product3, product4] = create_products(menu)

      {:ok, menu} = 
        Repo.get(Menu, menu.id)
        |> Repo.preload([products: [product_extra_menus: [product_extras: :product]]])
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

    test "create a product extra menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      
      params = %{product_id: product.id, name: "Sauces", hidden: false}
      ref = doc_push(socket, "create_product_extra_menu", %{params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_extra_menu_created", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, created_product_extra_menu} = Merchandise.get_product_extra_menu(decoded_data["id"])
      assert created_product_extra_menu.name == "Sauces"
      assert created_product_extra_menu.hidden == false
    end

    test "update a product extra menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product.id})

      params = %{name: "Must Pick One Sauce", mandatory: true, pick_only_one: true}
      ref = doc_push(socket, "update_product_extra_menu", %{product_extra_menu_id: product_extra_menu.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_extra_menu_updated", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, updated_product_extra_menu} = Merchandise.get_product_extra_menu(decoded_data["id"])
      assert updated_product_extra_menu.name == "Must Pick One Sauce"
      assert updated_product_extra_menu.mandatory == true
      assert updated_product_extra_menu.pick_only_one == true
    end

    test "delete a product extra menu", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product.id})

      product_extra_menu_id = product_extra_menu.id

      ref = doc_push(socket, "delete_product_extra_menu", %{product_extra_menu_id: product_extra_menu.id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_extra_menu_deleted", %{message: message, product_extra_menu_id: ^product_extra_menu_id})
      |> doc()

      deleted_product_extra_menu = Merchandise.get_product_extra_menu(product_extra_menu_id)
      assert ^deleted_product_extra_menu = {:error, :not_found}
    end

    test "create a product extra", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product.id, name: "Sauces"})

      {:ok, unlisted_product} = unlisted_product_fixture(%{restaurant_id: restaurant.id, new_name: "Sauce Y"})
      
      ref = doc_push(socket, "create_product_extra", %{product_extra_menu_id: product_extra_menu.id, new_name: unlisted_product.name, new_price: 1000, product_id: unlisted_product.id, hidden: false})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_extra_created", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, created_product_extra} = Merchandise.get_product_extra(decoded_data["id"])
      assert Merchandise.price_to_string(created_product_extra.new_price) == "10:-"
    end

    test "update a product extra", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product.id})
      {:ok, unlisted_product} = unlisted_product_fixture(%{restaurant_id: restaurant.id})

      {:ok, product_extra} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id, product_id: unlisted_product.id, new_name: "Sauce Y", new_price: 900})

      params = %{new_name: "Sauce X"}
      ref = doc_push(socket, "update_product_extra", %{product_extra_id: product_extra.id, params: params})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_extra_updated", %{data: data})
      |> doc()

      {:ok, decoded_data} = JSON.decode(data, [strings: :copy])
      {:ok, updated_product_extra} = Merchandise.get_product_extra(decoded_data["id"])
      assert updated_product_extra.new_name == "Sauce X"
    end

    test "delete a product extra", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      {:ok, product_extra_menu} = product_extra_menu_fixture(%{product_id: product.id})
      {:ok, unlisted_product} = unlisted_product_fixture(%{restaurant_id: restaurant.id})

      {:ok, product_extra} = product_extra_fixture(%{product_extra_menu_id: product_extra_menu.id, product_id: unlisted_product.id, new_name: "Sauce Y", new_price: 900})

      product_extra_id = product_extra.id

      ref = doc_push(socket, "delete_product_extra", %{product_extra_id: product_extra.id})
      assert_reply(ref, :ok)
      |> doc()
      assert_broadcast("product_extra_deleted", %{message: message, product_extra_id: ^product_extra_id})
      |> doc()

      deleted_product_extra = Merchandise.get_product_extra(product_extra_id)
      assert ^deleted_product_extra = {:error, :not_found}
    end
  end

  describe "try to do user actions as a guest -" do
    setup :guest

    test "create a product without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      
      ref = push(socket, "create_product", %{menu_id: menu.id, name: "test product 99", price: 99_00})
      assert_reply ref, :error, %{message: "Unauthorized"}
    end

    test "update a product without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})

      params = %{name: "some new name"}
      ref = push(socket, "update_product", %{product_id: product.id, params: params})
      refute_reply(ref, :ok)
      refute_broadcast("product_updated", %{message: _data})
    end

    test "delete a product without logging in", %{socket: socket} do
      {:ok, restaurant} = restaurant_fixture()
      {:ok, menu} = menu_fixture(%{restaurant_id: restaurant.id})
      {:ok, product} = product_fixture(%{menu_id: menu.id})
      product_id = product.id

      ref = push(socket, "delete_product", %{product_id: product.id})
      refute_reply(ref, :ok)
      refute_broadcast("product_deleted", %{message: _message, product_id: ^product_id})
    end
  end
end
