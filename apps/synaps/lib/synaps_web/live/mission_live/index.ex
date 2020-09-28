defmodule SynapsWeb.MissionLive.Index do
  use SynapsWeb, :live_view

  alias Db.Bookings
  alias Db.Bookings.Mission

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :missions, list_missions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Ändra tid")
    |> assign(:mission, Bookings.get_mission!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Ny tid")
    |> assign(:mission, %Mission{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Alla tider")
    |> assign(:mission, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mission = Bookings.get_mission!(id)
    {:ok, _} = Bookings.delete_mission(mission)

    {:noreply, assign(socket, :missions, list_missions())}
  end

  defp list_missions do
    Bookings.list_missions()
  end
end
