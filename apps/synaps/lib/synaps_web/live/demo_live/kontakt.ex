defmodule SynapsWeb.DemoLive.Kontakt do
  use SynapsWeb, :live_view

  alias Db.Bookings
  alias Db.Bookings.Demo

  @impl true
  def mount(_params, _session, socket) do
    changeset = Bookings.change_demo(%Demo{})
    {:ok, assign(socket, changeset: changeset, title: "Forma kontakt", done: false)}
  end

  def handle_event("logo_button", _, socket) do
    {:noreply, redirect(socket, to: "/")}
  end

  def handle_event("back", _, socket) do
    {:noreply, redirect(socket, to: "/")}
  end

  @impl true
  def handle_event("validate", %{"demo" => demo_params}, socket) do
    changeset =
      %Demo{}
      |> Bookings.change_demo(demo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"demo" => demo_params}, socket) do
    save_demo(socket, :new, demo_params)
  end

  defp save_demo(socket, :new, demo_params) do
    case Bookings.create_demo(demo_params) do
      {:ok, _demo} ->
        {:noreply,
         socket
         |> assign(:done, true)
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end