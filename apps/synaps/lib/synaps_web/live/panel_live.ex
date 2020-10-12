defmodule SynapsWeb.PanelLive do
  use SynapsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("goto_categories", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.category_index_path(socket, :index))}
  end

  def handle_event("goto_demo", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.demo_index_path(socket, :index))}
  end

  def handle_event("goto_missions", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.mission_index_path(socket, :index))}
  end
end
