defmodule MatxWeb.PageLive do
  use MatxWeb, :live_view

  alias MatxWeb.UserAuth

  def mount(_params, %{"user_token" => user_token} = conn, socket) do
    current_user = Db.Accounts.get_user_by_session_token(user_token)
    {:ok, assign(socket, value: "", val: "", current_user: current_user, mail: current_user.email)}
  end

  def mount(_params, conn, socket) do
    IO.inspect conn
    IO.puts "lolololl"
    {:ok, assign(socket, value: "", val: "", current_user: "", mail: "")}
  end

  def render(assigns, _socket) do
    Phoenix.View.render(MatxWeb.PageView, "page_live.html", assigns)
  end

  def handle_event("search", %{"session" => %{"value" => value}}, socket) do
    {:noreply, assign(socket, value: value)}
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
