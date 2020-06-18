defmodule MatxWeb.PageLive do
  use MatxWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, val: 1)}
  end

  @impl true
  def handle_event("step1", _, socket) do
    {:noreply, assign(socket, val: 2)}
  end

  @impl true
  def handle_event("step2", _, socket) do
    {:noreply, assign(socket, val: 3)}
  end

  @impl true
  def handle_event("step3", _, socket) do
    {:noreply, assign(socket, val: 1)}
  end

end
