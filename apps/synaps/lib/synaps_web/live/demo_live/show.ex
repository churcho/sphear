defmodule SynapsWeb.DemoLive.Show do
  use SynapsWeb, :live_view

  alias Db.Bookings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:demo, Bookings.get_demo!(id))}
  end

  defp page_title(:show), do: "Show Demo"
  defp page_title(:edit), do: "Edit Demo"
end
