defmodule MatxWeb.RegisterLive do
    use MatxWeb, :live_view
    
    alias Db.Accounts
  
    def mount(_params, _session, socket) do
      {:ok, assign(socket, error: "", changeset: Entrance.User.create_changeset)}
    end

    def render(assigns, _socket) do
      Phoenix.View.render(MatxWeb.RegisterView, "register_live.html", assigns)
    end


    def handle_event("post", %{"user" => %{"email" => email}, "password" => password, "password_confirmation" => password_confirmation}, socket) do
      case Accounts.create_user(%{email: email, password: password, password_confirmation: password_confirmation}) do
        {:ok, _user} ->
          socket = 
            socket
            |> put_flash(:info, "Ditt konto har skapats! Du kan nu logga in.")
          {:noreply, push_redirect(socket, to: "/login")}
        {:error, changeset} ->
          {:noreply, assign(socket, error: "Something went wrong", changeset: changeset)}
      end
    end

    def handle_event("home", _, socket) do
      {:noreply, push_redirect(socket, to: "/demo")}
    end

    def handle_event("login", _, socket) do
      {:noreply, push_redirect(socket, to: "/login")}
    end
  end