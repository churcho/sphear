defmodule MatxWeb.PageLive do
  use MatxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, value: "", val: "")}
  end

  def render(assigns, _socket) do
    Phoenix.View.render(MatxWeb.PageView, "page_live.html", assigns)
  end

  def handle_event("search", %{"session" => %{"value" => value}}, socket) do
    {:noreply, assign(socket, value: value)}
  end

  def handle_event("login", _, socket) do
    {:noreply, push_redirect(socket, to: "/login")}
  end

  def handle_event("register", _, socket) do
    {:noreply, push_redirect(socket, to: "/register")}
  end
end
