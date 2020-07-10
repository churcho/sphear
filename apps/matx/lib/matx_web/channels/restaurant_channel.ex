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

  def handle_in("get", %{"id" => "all"}, socket) do
    restaurants = Feeders.list_restaurants()
    {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "index.json", restaurants: restaurants)}}, socket}
  end
  def handle_in("get", %{"id" => id}, socket) do
    case Feeders.get_restaurant(id) do
      nil ->
        {:reply, 
          {:error, %{message: "Could not find restaurant"}},
          socket}
      restaurant ->
        {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)}}, socket}
      end
  end
  def handle_in("get", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'id'"}},
    socket}
  end

  def handle_in("create", restaurant_params, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.create_restaurant(restaurant_params) do
          {:ok, restaurant} ->
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

  def handle_in("delete", %{"id" => id}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_restaurant(id) do
          nil ->
            {:reply, 
              {:error, %{message: "Could not find restaurant with id: " <> id}},
              socket}
          restaurant ->
            {:ok, _} = Feeders.delete_restaurant(restaurant)
            MatxWeb.Endpoint.broadcast!("restaurants:lobby", "restaurant_deleted", %{message: "Deleted restaurant '#{restaurant.name}'", id: restaurant.id})
            {:reply, 
              {:ok, %{message: "Deleted restaurant '#{restaurant.name}' with id #{restaurant.id}"}}, 
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
        case Feeders.get_restaurant(id) do
          nil ->
            {:reply, 
              {:error, %{message: "Could not find restaurant with id: " <> id}},
              socket}
          restaurant ->
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