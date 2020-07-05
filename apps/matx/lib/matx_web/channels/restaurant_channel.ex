defmodule MatxWeb.RestaurantChannel do
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
  def join("restaurants:lobby", _, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    #restaurants = Phoenix.View.render(socket, "index.json", restaurants: Feeders.list_restaurants())
    push(socket, "lobby", %{success: true})
    {:noreply, socket}
  end

  def handle_in("ping", _, socket) do
    {:reply, {:ok, %{message: "pong"}}, socket}
  end

  def handle_in("get", %{"id" => "all"}, socket) do
    restaurants = Feeders.list_restaurants()
    {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "index.json", restaurants: restaurants)}}, socket}
  end
  def handle_in("get", %{"id" => id}, socket) do
    restaurant = Feeders.get_restaurant!(id)
    {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)}}, socket}
  end

  def handle_in("create", restaurant_params, socket) do
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
  def handle_in("create", _, socket) do
    {:reply, 
    {:error, %{data: "Missing 'params'"}},
    socket}
  end

  def handle_in("delete", %{"id" => id}, socket) do
    case Feeders.get_restaurant(id) do
      restaurant ->
        id = restaurant.id
        {:ok, _} = Feeders.delete_restaurant(restaurant)
        MatxWeb.Endpoint.broadcast!("restaurants:lobby", "restaurant_deleted", %{id: id})
        {:reply, 
          {:ok, %{data: "Deleted restaurant with id: " <> id}}, 
          socket}
      _ ->
        {:reply, 
          {:error, %{data: "Could not find restaurant with id: " <> id}},
          socket}
      end
  end
  def handle_in("delete", _, socket) do
    {:reply, 
    {:error, %{data: "Missing 'id'"}},
    socket}
  end

  def handle_in("update", %{"id" => id, "params" => params}, socket) do
    case Feeders.get_restaurant(id) do
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
      _ ->
        {:reply, 
          {:error, %{data: "Could not find restaurant with id: " <> id}},
          socket}
    end
  end
  def handle_in("update", _, socket) do
    {:reply,
    {:error, %{data: "Missing 'id' or 'params'"}},
    socket}
  end

  def handle_in("logged_in", %{"token" => token}, socket) do
    IO.inspect("@@@@@@@@@@@@ start logged in")
    case auth_token(socket, token) do
      {:ok, user} ->
        IO.inspect("@@@@@@@@@@@@ auth socket")
        {:reply, 
          {:ok, %{user_id: user.id}},
          socket}
      {:error, error_message} ->
        {:reply, 
          {:error, %{data: error_message}},
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