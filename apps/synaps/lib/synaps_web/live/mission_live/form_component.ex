defmodule SynapsWeb.MissionLive.FormComponent do
  use SynapsWeb, :live_component

  alias Db.Bookings

  @impl true
  def update(%{mission: mission} = assigns, socket) do
    changeset = Bookings.change_mission(mission)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"mission" => mission_params}, socket) do
    changeset =
      socket.assigns.mission
      |> Bookings.change_mission(mission_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"mission" => mission_params}, socket) do
    save_mission(socket, socket.assigns.action, mission_params)
  end

  defp save_mission(socket, :edit, mission_params) do
    case Bookings.update_mission(socket.assigns.mission, mission_params) do
      {:ok, _mission} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mission updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_mission(socket, :new, mission_params) do
    case Bookings.create_mission(mission_params) do
      {:ok, _mission} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mission created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
