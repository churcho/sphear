defmodule MatxWeb.RestaurantChannel do
  use Phoenix.Channel
  require Logger

  alias Db.Feeders

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic
  Possible Return Values
  `{:ok, socket}` to authorize subscription for channel for requested topic
  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("restaurants:lobby", msg, socket) do
    IO.inspect msg
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

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

    #def join("restaurants:" <> "private", _message, _socket) do
  #  {:error, %{reason: "unauthorized"}}
  #end
end