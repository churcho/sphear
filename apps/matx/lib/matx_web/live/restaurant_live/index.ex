defmodule MatxWeb.RestaurantLive.Index do
  use MatxWeb, :live_view

  alias Db.Accounts
  alias Db.Feeders
  alias Db.Feeders.Restaurant

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    current_user = Db.Accounts.get_user_by_session_token(user_token)
    socket =
      socket
      |> assign(:restaurants, list_restaurants())
      |> assign(:email, current_user.email)
      |> assign(:selected_restaurant, nil)
    {:ok, socket}
  end

  def render(assigns, _socket) do
    Phoenix.View.render(MatxWeb.RestaurantView, "index.html", assigns)
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("restaurant_click", %{"id" => id}, socket) do
    if socket.assigns.selected_restaurant == String.to_integer(id) do
      {:noreply, assign(socket, :selected_restaurant, nil)}
    else
      selected_restaurant = String.to_integer(id)
      {:noreply, assign(socket, :selected_restaurant, selected_restaurant)}
    end
  end

  @impl true
  def handle_event("reset_restaurant", _, socket) do
    {:noreply, assign(socket, :selected_restaurant, nil)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Ändra restaurang")
    |> assign(:restaurant, Feeders.get_restaurant!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Ny restaurang")
    |> assign(:restaurant, %Restaurant{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Alla restauranger")
    |> assign(:restaurant, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    restaurant = Feeders.get_restaurant!(id)
    {:ok, _} = Feeders.delete_restaurant(restaurant)

    {:noreply, assign(socket, :restaurants, list_restaurants())}
  end

  defp list_restaurants do
    Feeders.list_restaurants()
    |> Enum.sort_by(&(&1.name))
  end
end
