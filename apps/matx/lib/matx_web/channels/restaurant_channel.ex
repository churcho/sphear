defmodule MatxWeb.Channels.RestaurantChannel do
  use Phoenix.Channel
  require Logger
  import MatxWeb.UserAuth

  alias Db.Feeders

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic
  Possible Return Values
  `{:ok, socket}` to authorize subscription for channel for requested topic
  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("restaurants:lobby", %{"token" => token}, socket) do
    case auth_token(socket, token) do
      {:ok, user} ->
        socket = assign(socket, :user_id, user.id)
        send(self(), :user_join)
        {:ok, socket}
      {:error, error_message} ->
        {:error, error_message}
    end
  end
  def join("restaurants:lobby", _, socket) do
    send(self(), :guest_join)
    {:ok, socket}
  end

  def handle_info(:user_join, socket) do
    #restaurants = Phoenix.View.render(socket, "index.json", restaurants: Feeders.list_restaurants())
    push(socket, "lobby", %{login_success: true, user_id: socket.assigns[:user_id]})
    {:noreply, socket}
  end

  def handle_info(:guest_join, socket) do
    #restaurants = Phoenix.View.render(socket, "index.json", restaurants: Feeders.list_restaurants())
    push(socket, "lobby", %{guest_success: true, user_id: nil})
    {:noreply, socket}
  end

  def handle_info(:ping, socket) do
    {:noreply, socket}
  end

  def handle_in("ping", _, socket) do
    {:reply, {:ok, %{message: "pong"}}, socket}
  end

  def handle_in("goodbye", _, socket) do
    {:stop, :normal, socket}
  end

  def handle_in("get_restaurants", _, socket) do
    restaurants = Feeders.list_restaurants()
    {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "index.json", restaurants: restaurants)}}, socket}
  end

  def handle_in("get_restaurant", %{"restaurant_id" => id}, socket) do
    case Feeders.get_restaurant(id) do
      {:error, _} ->
        {:reply, 
          {:error, %{message: "Could not find restaurant"}},
          socket}
      {:ok, restaurant} ->
        {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)}}, socket}
      end
  end
  def handle_in("get_restaurant", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'restaurant_id'"}},
    socket}
  end

  def handle_in("create_restaurant", restaurant_params, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.create_restaurant(restaurant_params) do
          {:ok, restaurant} ->
            restaurant = Db.Repo.preload(restaurant, :menus)
            MatxWeb.Endpoint.broadcast!("restaurants:lobby", "restaurant_created", %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)})
            {:reply,
            {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)}},
            socket}
          {:error, %Ecto.Changeset{} = changeset} ->
            {:reply,
              {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
            socket}
        end
    end
  end

  def handle_in("delete_restaurant", %{"restaurant_id" => id}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_restaurant(id) do
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find restaurant with id: " <> id}},
              socket}
          {:ok, restaurant} ->
            {:ok, _} = Feeders.delete_restaurant(restaurant)
            MatxWeb.Endpoint.broadcast!("restaurants:lobby", "restaurant_deleted", %{message: "Deleted restaurant '#{restaurant.name}'", restaurant_id: restaurant.id})
            {:reply, 
              {:ok, %{message: "Deleted restaurant '#{restaurant.name}' with id #{restaurant.id}"}}, 
              socket}
          end
      end
  end
  def handle_in("delete_restaurant", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'restaurant_id'"}},
    socket}
  end

  def handle_in("update_restaurant", %{"restaurant_id" => id, "params" => params}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_restaurant(id) do
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find restaurant with id: " <> id}},
              socket}
          {:ok, restaurant} ->
            case Feeders.update_restaurant(restaurant, params) do
              {:ok, restaurant} ->
                MatxWeb.Endpoint.broadcast!("restaurants:lobby", "restaurant_updated", %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)})
                {:reply, 
                  {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)}}, 
                  socket}
              {:error, %Ecto.Changeset{} = changeset} ->
                {:reply,
                  {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
                  socket}
            end
        end
    end
  end
  def handle_in("update_restaurant", _, socket) do
    {:reply,
    {:error, %{message: "Missing 'restaurant_id' or 'params'"}},
    socket}
  end

  # # # # # # #
  # M E N U S #
  # # # # # # #

  def handle_in("get_menus", %{"restaurant_id" => id}, socket) do
    case Feeders.get_restaurant(id) do
      {:ok, restaurant} ->
        menus = EctoList.ordered_items_list(restaurant.menus, restaurant.menus_order)
        {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "index.json", menus: menus)}}, socket}
      {:error, :not_found} ->
        {:reply, 
          {:error, %{message: "Could not find restaurant"}},
          socket}
    end
  end
  def handle_in("get_menus", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'restaurant_id'"}},
    socket}
  end

  def handle_in("get_menu", %{"menu_id" => id}, socket) do
    case Feeders.get_menu(id) do
      {:ok, menu} ->
        {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)}}, socket}
      {:error, :not_found} ->
        {:reply, 
          {:error, %{message: "Could not find menu"}},
          socket}
    end
  end
  def handle_in("get_menu", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'menu_id'"}},
    socket}
  end

  def handle_in("create_menu", menu_params, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.create_menu(menu_params) do
          {:ok, menu} ->
            MatxWeb.Endpoint.broadcast!("restaurants:lobby", "menu_created", %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)})
            {:reply,
            {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)}},
            socket}
          {:error, %Ecto.Changeset{} = changeset} ->
            {:reply,
              {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
            socket}
        end
    end
  end

  def handle_in("delete_menu", %{"menu_id" => id}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_menu(id) do
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find menu with id: " <> id}},
              socket}
          {:ok, menu} ->
            {:ok, _} = Feeders.delete_menu(menu)
            MatxWeb.Endpoint.broadcast!("restaurants:lobby", "menu_deleted", %{message: "Deleted menu '#{menu.name}'", menu_id: menu.id})
            {:reply, 
              {:ok, %{message: "Deleted menu '#{menu.name}' with id #{menu.id}"}}, 
              socket}
          end
      end
  end
  def handle_in("delete_menu", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'menu_id'"}},
    socket}
  end

  def handle_in("update_menu", %{"menu_id" => id, "params" => params}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_menu(id) do
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find menu with id: " <> id}},
              socket}
          {:ok, menu} ->
            case Feeders.update_menu(menu, params) do
              {:ok, menu} ->
                MatxWeb.Endpoint.broadcast!("restaurants:lobby", "menu_updated", %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)})
                {:reply, 
                  {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)}}, 
                  socket}
              {:error, %Ecto.Changeset{} = changeset} ->
                {:reply,
                  {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
                  socket}
            end
        end
    end
  end
  def handle_in("update_menu", _, socket) do
    {:reply,
    {:error, %{message: "Missing 'menu_id' or 'params'"}},
    socket}
  end

  def handle_in("change_menu_order", %{"restaurant_id" => restaurant_id, "menu_id" => menu_id, "action" => "insert_at", "index" => index}, socket) do
    change_menu_order(restaurant_id, menu_id, "insert_at", index, socket)
  end
  def handle_in("change_menu_order", %{"restaurant_id" => _restaurant_id, "menu_id" => _menu_id, "action" => "insert_at"}, socket) do
    {:reply,
    {:error, %{message: "Expected 'index' param when action is 'insert_at'"}},
    socket}
  end
  def handle_in("change_menu_order", %{"restaurant_id" => restaurant_id, "menu_id" => menu_id, "action" => action}, socket) do
    change_menu_order(restaurant_id, menu_id, action, nil, socket)
  end
  def handle_in("change_menu_order", _, socket) do
    {:reply,
    {:error, %{message: "Expected 'restaurant_id', 'menu_id' and 'action' params"}},
    socket}
  end

  defp change_menu_order(restaurant_id, menu_id, action, index, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_restaurant(restaurant_id) do
          {:ok, restaurant} ->
            case changeset_menu_order(restaurant, menu_id, action, index) do
              {:ok, restaurant} ->
                menus = EctoList.ordered_items_list(restaurant.menus, restaurant.menus_order)
                {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "index.json", menus: menus)}}, socket}
              {:error, :action_not_found} ->
                {:reply,
                  {:error, %{message: "Unknown action"}},
                socket}
              {:error, %Ecto.Changeset{} = changeset} ->
                {:reply,
                  {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
                socket}
            end
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find restaurant with id: " <> restaurant_id}},
              socket}
        end
    end
  end

  defp changeset_menu_order(restaurant, menu_id, action, index) do
    case action do
      "higher" ->
        Feeders.change_menu_order(restaurant, menu_id, :higher)
        |> Db.Repo.update()
      "lower" ->
        Feeders.change_menu_order(restaurant, menu_id, :lower)
        |> Db.Repo.update()
      "to_top" ->
        Feeders.change_menu_order(restaurant, menu_id, :to_top)
        |> Db.Repo.update()
      "to_bottom" ->
        Feeders.change_menu_order(restaurant, menu_id, :to_bottom)
        |> Db.Repo.update()
      "insert_at" ->
        Feeders.change_menu_order(restaurant, menu_id, index, :insert)
        |> Db.Repo.update()
      _ ->
        {:error, :action_not_found}
    end
  end

  ################

  def handle_in("logged_in", _, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      user_id ->
        {:reply, 
          {:ok, %{user_id: user_id}},
          socket}
    end
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end
end