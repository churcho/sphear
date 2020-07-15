defmodule MatxWeb.PageLive do
  use MatxWeb, :live_view

  alias MatxWeb.UserAuth
  alias MatxWeb.SearchModel
  alias Db.Feeders.Restaurant
  alias Db.Feeders

  def mount(_params, %{"user_token" => user_token} = conn, socket) do
    current_user = Db.Accounts.get_user_by_session_token(user_token)
    socket =
      socket
      |> initialize_search_model

    {:ok, assign(socket, email: current_user.email, map_open: false, searching: false)}
  end

  def mount(_params, conn, socket) do
    socket =
      socket
      |> initialize_search_model

    {:ok, assign(socket, email: "", map_open: false, searching: false)}
  end

  defp initialize_search_model(socket) do
    {:ok, search_model} = SearchModel.new(search_function: &Feeders.suggest/1)

    socket
    |> assign(search_model: search_model)
  end

  defp prepare_query(socket, search) do
    socket
    |> update(:search_model, &SearchModel.prepare_query(&1, search))
  end

  defp execute_query(socket) do
    socket
    |> update(:search_model, &SearchModel.execute_query(&1))
  end

  def render(assigns, _socket) do
    Phoenix.View.render(MatxWeb.PageView, "page_live.html", assigns)
  end

  def handle_event("search", %{"search" => search}, socket) do
    send(self(), :run_restaurant_search)

    socket =
      socket
      |> prepare_query(search)

    {:noreply, socket}
  end

  def handle_info(:run_restaurant_search, socket) do
    socket =
      socket
      |> execute_query

    {:noreply, socket}
  end

  def handle_event("reset_search", %{"search" => search}, socket) do
    case search do
      "" ->
        {:noreply, socket}
      _ ->
        {:ok, search_model} = SearchModel.new
        {:noreply, assign(socket, search_model: search_model)}
    end
  end

  def handle_event("search_focus", _, socket) do
    {:noreply, assign(socket, searching: true)}
  end

  def handle_event("search_blur", _, socket) do
    Process.sleep(50)
    {:noreply, assign(socket, searching: false)}
  end

  # No map, search and no restaurants should open map and show all restaurants
  def handle_event("map_click", _, %{assigns: %{map_open: false, search_model: %{"search": "", "restaurants": []}}} = socket) do
    restaurants = Feeders.list_restaurants
    {:ok, search_model} = SearchModel.new_restaurants(restaurants)
    {:noreply, assign(socket, map_open: true, search_model: search_model)}
  end
  # Edge case, if map is open and showing restaurants without searching for anything we should close it with the same button aswell
  def handle_event("map_click", _, %{assigns: %{map_open: true, search_model: %{"search": "", "restaurants": _}}} = socket) do
    {:ok, search_model} = SearchModel.new_restaurants([])
    {:noreply, assign(socket, map_open: false, search_model: search_model)}
  end
  def handle_event("map_click", _, socket) do
    {:noreply, assign(socket, map_open: true)}
  end

  # No list, search and no restaurants should show all restaurants
  def handle_event("list_click", _, %{assigns: %{search_model: %{"search": "", "restaurants": []}}} = socket) do
    restaurants = Feeders.list_restaurants
    {:ok, search_model} = SearchModel.new_restaurants(restaurants)
    {:noreply, assign(socket, map_open: false, search_model: search_model)}
  end
  # Edge case, if list is open and showing restaurants without searching for anything we should close it with the same button aswell
  def handle_event("list_click", _, %{assigns: %{map_open: false, search_model: %{"search": "", "restaurants": _}}} = socket) do
    {:ok, search_model} = SearchModel.new_restaurants([])
    {:noreply, assign(socket, map_open: false, search_model: search_model)}
  end
  def handle_event("list_click", _, socket) do
    {:noreply, assign(socket, map_open: false)}
  end

  def handle_event("restaurant_click", %{"id" => id}, socket) do
    with {:ok, restaurant} <- Db.Feeders.get_restaurant(id) do
      {:noreply, push_redirect(socket, to: Routes.restaurant_show_path(MatxWeb.Endpoint, :show, restaurant))}
    end
  end

  def handle_event("settings", _, socket) do
    {:noreply, redirect(socket, to: Routes.user_settings_path(MatxWeb.Endpoint, :edit))}
  end

  def handle_event("logout", _, socket) do
    {:noreply, redirect(socket, to: Routes.user_session_path(MatxWeb.Endpoint, :delete))}
  end

  def handle_event("login", _, socket) do
    {:noreply, redirect(socket, to: Routes.user_session_path(MatxWeb.Endpoint, :new))}
  end

  def handle_event("register", _, socket) do
    {:noreply, redirect(socket, to: Routes.user_registration_path(MatxWeb.Endpoint, :new))}
  end

  defp button_colors(:map, map_open) do
    case map_open do
      true ->
        "text-white bg-red-600"
      false ->
        "text-red-700 bg-white hover:text-white hover:bg-red-500 bg-opacity-25"
    end
  end

  defp button_colors(:list, map_open) do
    case map_open do
      false ->
        "text-white bg-red-600"
      true ->
        "text-red-700 bg-white hover:text-white hover:bg-red-500 bg-opacity-25"
    end
  end

end
