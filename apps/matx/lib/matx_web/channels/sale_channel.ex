defmodule MatxWeb.Channels.SaleChannel do
  use Phoenix.Channel
  require Logger
  import MatxWeb.UserAuth

  alias Db.Merchandise
  alias Db.Orders
  alias Db.Carts
  alias Db.Feeders
  alias Db.Repo

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic
  Possible Return Values
  `{:ok, socket}` to authorize subscription for channel for requested topic
  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("sale:lobby", %{"token" => token}, socket) do
    case auth_token(socket, token) do
      {:ok, user} ->
        socket = assign(socket, :user_id, user.id)
        send(self(), :user_join)
        {:ok, socket}
      {:error, error_message} ->
        {:error, error_message}
    end
  end
  def join("sale:lobby", _, socket) do
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

  # # # # # # # #
  # O R D E R S #
  # # # # # # # #

  

  ##########################

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