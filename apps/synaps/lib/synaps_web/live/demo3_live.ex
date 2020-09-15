defmodule SynapsWeb.Demo3Live do
  use SynapsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
