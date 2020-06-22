defmodule MatxWeb.LoginLive do
    use MatxWeb, :live_view

    import Entrance.Login.Session, only: [login: 2, logout: 1]
  
    def mount(_params, _session, socket) do
      {:ok, assign(socket, error: "")}
    end

    def render(assigns, _socket) do
      Phoenix.View.render(MatxWeb.LoginView, "login_live.html", assigns)
    end

    def handle_event("post", %{"session" => %{"email" => email}, "password" => password}, socket) do
      if user = Entrance.auth(email, password) do
        socket
        |> login(user)
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