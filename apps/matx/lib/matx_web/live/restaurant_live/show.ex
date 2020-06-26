defmodule MatxWeb.RestaurantLive.Show do
  use MatxWeb, :live_view

  alias Db.Feeders

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    current_user = Db.Accounts.get_user_by_session_token(user_token)
    email = current_user.email
    {:ok, assign(socket, :email, email)}
  end

  @impl true
  def mount(_params, _, socket) do
    {:ok, assign(socket, :email, nil)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:restaurant, Feeders.get_restaurant!(id))}
  end

  defp page_title(:show), do: "Show Restaurant"
  defp page_title(:edit), do: "Edit Restaurant"
end
