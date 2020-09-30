defmodule SynapsWeb.CategoryLive.Index do
  use SynapsWeb, :live_view

  alias Db.Bookings
  alias Db.Bookings.Category

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :categories, list_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("back", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.panel_path(socket, :index))}
  end

  def handle_event("new", _, socket) do
    {:noreply, push_patch(socket, to: Routes.category_index_path(socket, :new))}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Ändra kategori")
    |> assign(:category, Bookings.get_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Ny kategori")
    |> assign(:category, %Category{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Alla kategorier")
    |> assign(:category, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    category = Bookings.get_category!(id)
    {:ok, _} = Bookings.delete_category(category)

    {:noreply, assign(socket, :categories, list_categories())}
  end

  defp list_categories do
    Bookings.list_categories()
  end
end
