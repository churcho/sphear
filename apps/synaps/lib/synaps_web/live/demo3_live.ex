defmodule SynapsWeb.Demo3Live do
  use SynapsWeb, :live_view

  alias Db.Bookings
  alias Db.Bookings.Mission

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :missions, list_missions())}
  end

  def handle_event("logo_button", _, socket) do
    {:noreply, redirect(socket, to: "/demo")}
  end

  defp list_missions do
    Bookings.list_missions()
  end
end
