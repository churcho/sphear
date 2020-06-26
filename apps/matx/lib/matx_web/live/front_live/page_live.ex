defmodule MatxWeb.PageLive do
  use MatxWeb, :live_view

  alias MatxWeb.UserAuth
  alias MatxWeb.PresentationModel
  alias Db.Feeders.Restaurant
  alias Db.Feeders

  def mount(_params, %{"user_token" => user_token} = conn, socket) do
    current_user = Db.Accounts.get_user_by_session_token(user_token)
    socket =
      socket
      |> initialize_presentation_model

    {:ok, assign(socket, email: current_user.email)}
  end

  def mount(_params, conn, socket) do
    socket =
      socket
      |> initialize_presentation_model

    {:ok, assign(socket, email: "")}
  end

  defp initialize_presentation_model(socket) do
    {:ok, presentation_model} = PresentationModel.new(search_function: &Feeders.suggest/1)

    socket
    |> assign(presentation_model: presentation_model)
  end

  defp prepare_query(socket, search) do
    socket
    |> update(:presentation_model, &PresentationModel.prepare_query(&1, search))
  end

  defp execute_query(socket) do
    socket
    |> update(:presentation_model, &PresentationModel.execute_query(&1))
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

  def handle_event("restaurant_click", %{"id" => id}, socket) do
    {:noreply, push_redirect(socket, to: Routes.restaurant_show_path(MatxWeb.Endpoint, :show, Db.Feeders.get_restaurant!(id)))}
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
end
