defmodule SynapsWeb.DemoLive do
  use SynapsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("demo_button", _, socket) do
    #{:noreply, redirect(socket, to: "/demo3")}
    {:noreply, socket}
  end
end
