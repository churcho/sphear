defmodule MatxWeb.LoginLive do
    use MatxWeb, :live_view
  
    def mount(_params, session, socket) do
      IO.inspect session
      {:ok, assign(socket, error: "", session: session)}
    end

    def render(assigns, _socket) do
      Phoenix.View.render(MatxWeb.LoginView, "login_live.html", assigns)
    end

    def handle_event("post", %{"session" => %{"email" => email}, "password" => password}, socket) do
      if user = "" do
        socket
        |> put_flash(:info, "Successfully logged in")
        |> push_redirect(to: "/")
      else
        {:noreply, assign(socket, :error, "No user found with the provided credentials")}
      end
    end

    def handle_event("home", _, socket) do
      {:noreply, push_redirect(socket, to: "/demo")}
    end

    def handle_event("register", _, socket) do
      {:noreply, push_redirect(socket, to: "/register")}
    end
  end