defmodule MatxWeb.RestaurantLive.FormComponent do
  use MatxWeb, :live_component

  alias Db.Feeders

  @impl true
  def update(%{restaurant: restaurant} = assigns, socket) do
    changeset = Feeders.change_restaurant(restaurant)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"restaurant" => restaurant_params}, socket) do
    changeset =
      socket.assigns.restaurant
      |> Feeders.change_restaurant(restaurant_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"restaurant" => restaurant_params}, socket) do
    save_restaurant(socket, socket.assigns.action, restaurant_params)
  end

  defp save_restaurant(socket, :edit, restaurant_params) do
    case Feeders.update_restaurant(socket.assigns.restaurant, restaurant_params) do
      {:ok, restaurant} ->
        MatxWeb.Endpoint.broadcast!("restaurants:lobby", "restaurant_changed", %{data: Phoenix.View.render_to_string(MatxWeb.Api.RestaurantView, "show.json", restaurant: restaurant)})
        {:noreply,
         socket
         |> put_flash(:info, "Restaurang #{restaurant.name} uppdaterades")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_restaurant(socket, :new, restaurant_params) do
    case Feeders.create_restaurant(restaurant_params) do
      {:ok, restaurant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Restaurang #{restaurant.name} skapades")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
