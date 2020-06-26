defmodule MatxWeb.HeaderLive do
  use MatxWeb, :live_component

  alias MatxWeb.UserAuth

  def mount(_params, %{"user_token" => user_token} = conn, socket) do
    case Db.Accounts.get_user_by_session_token(user_token) do
      current_user ->
        {:ok, assign(socket, email: current_user.email)}
      _ ->
        {:noreply, redirect(socket, to: Routes.page_path(MatxWeb.Endpoint, :demo))}
    end
  end

  def mount(_params, conn, socket) do
    {:ok, assign(socket, email: "")}
  end

  def render(assigns, _socket) do
    Phoenix.View.render(MatxWeb.HeaderView, "header_live.html", assigns)
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

  def handle_event("button", %{"view" => view}, socket) do
    case view do
      "Elixir.MatxWeb.PageLive" ->
        {:noreply, push_redirect(socket, to: "/restaurants")}
      _ ->
        {:noreply, push_redirect(socket, to: "/demo")}
      end
  end
end
