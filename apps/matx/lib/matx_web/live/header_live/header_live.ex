defmodule MatxWeb.HeaderLive do
  use MatxWeb, :live_component

  alias MatxWeb.UserAuth

  def mount(_params, %{"user_token" => user_token} = conn, socket) do
    case Db.Accounts.get_user_by_session_token(user_token) do
      current_user ->
        {:noreply, assign(socket, email: current_user.email, open: false, hide: false)}
      _ ->
        {:noreply, redirect(socket, to: Routes.page_path(MatxWeb.Endpoint, :demo))}
    end
  end

  def mount(_params, conn, socket) do
    {:noreply, assign(socket, email: "", open: false, hide: false)}
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
        if socket.assigns.email == "" do
          {:noreply, redirect(socket, to: Routes.user_session_path(MatxWeb.Endpoint, :new))}
        else
          {:noreply, push_redirect(socket, to: "/restaurants")}
        end
      _ ->
        {:noreply, push_redirect(socket, to: "/demo")}
    end
  end

  def handle_event("button_mobile", %{"open" => open}, socket) do
    {:noreply, assign(socket, open: !socket.assigns.open)}
  end

  def handle_event("button_mobile_blur", _, socket) do
    Process.sleep(50)
    {:noreply, assign(socket, open: false)}
  end
end
