defmodule SynapsWeb.DemoLive.FormComponent do
  use SynapsWeb, :live_component

  alias Db.Bookings

  @impl true
  def update(%{demo: demo} = assigns, socket) do
    changeset = Bookings.change_demo(demo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"demo" => demo_params}, socket) do
    changeset =
      socket.assigns.demo
      |> Bookings.change_demo(demo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"demo" => demo_params}, socket) do
    save_demo(socket, socket.assigns.action, demo_params)
  end

  defp save_demo(socket, :edit, demo_params) do
    case Bookings.update_demo(socket.assigns.demo, demo_params) do
      {:ok, _demo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Demo updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_demo(socket, :new, demo_params) do
    case Bookings.create_demo(demo_params) do
      {:ok, _demo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Demo created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
