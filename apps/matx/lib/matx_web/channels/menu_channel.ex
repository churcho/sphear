defmodule MatxWeb.Channels.MenuChannel do
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
  def join("menus:lobby", %{"token" => token}, socket) do
    case auth_token(socket, token) do
      {:ok, user} ->
        socket = assign(socket, :user_id, user.id)
        send(self(), :user_join)
        {:ok, socket}
      {:error, error_message} ->
        {:error, error_message}
    end
  end
  def join("menus:lobby", _, socket) do
    send(self(), :guest_join)
    {:ok, socket}
  end

  def handle_info(:user_join, socket) do
    push(socket, "lobby", %{login_success: true, user_id: socket.assigns[:user_id]})
    {:noreply, socket}
  end

  def handle_info(:guest_join, socket) do
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

  def handle_in("get", %{"restaurant_id" => id}, socket) do
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
  def handle_in("get", %{"menu_id" => id}, socket) do
    case Feeders.get_menu(id) do
      {:ok, menu} ->
        {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)}}, socket}
      {:error, :not_found} ->
        {:reply, 
          {:error, %{message: "Could not find menu"}},
          socket}
    end
  end
  def handle_in("get", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'restaurant_id' or 'menu_id'"}},
    socket}
  end

  def handle_in("create", menu_params, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.create_menu(menu_params) do
          {:ok, menu} ->
            MatxWeb.Endpoint.broadcast!("menus:lobby", "menu_created", %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)})
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
  def handle_in("create", _, socket) do
    {:reply, 
    {:error, %{message: "Missing menu 'id'"}},
    socket}
  end

  def handle_in("delete", %{"id" => id}, socket) do
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
            MatxWeb.Endpoint.broadcast!("menus:lobby", "menu_deleted", %{message: "Deleted menu '#{menu.name}'", id: menu.id})
            {:reply, 
              {:ok, %{message: "Deleted menu '#{menu.name}' with id #{menu.id}"}}, 
              socket}
          end
      end
  end
  def handle_in("delete", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'id'"}},
    socket}
  end

  def handle_in("update", %{"id" => id, "params" => params}, socket) do
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
                MatxWeb.Endpoint.broadcast!("menus:lobby", "menu_updated", %{data: Phoenix.View.render_to_string(MatxWeb.Api.MenuView, "show.json", menu: menu)})
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
  def handle_in("update", _, socket) do
    {:reply,
    {:error, %{message: "Missing 'id' or 'params'"}},
    socket}
  end

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

    #def join("restaurants:" <> "private", _message, _socket) do
  #  {:error, %{reason: "unauthorized"}}
  #end
end