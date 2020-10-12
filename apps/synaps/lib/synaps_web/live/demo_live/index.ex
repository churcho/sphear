defmodule SynapsWeb.DemoLive.Index do
  use SynapsWeb, :live_view

  alias Db.Bookings
  alias Db.Bookings.Demo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :demo_collection, list_demo())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("back", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.panel_path(socket, :index))}
  end

  def handle_event("new", _, socket) do
    {:noreply, push_patch(socket, to: Routes.demo_index_path(socket, :new))}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Demo")
    |> assign(:demo, Bookings.get_demo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Demo")
    |> assign(:demo, %Demo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Demo")
    |> assign(:demo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    demo = Bookings.get_demo!(id)
    {:ok, _} = Bookings.delete_demo(demo)

    {:noreply, assign(socket, :demo_collection, list_demo())}
  end

  defp list_demo do
    Bookings.list_demo()
  end
end
