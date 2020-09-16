defmodule SynapsWeb.PageLive do
  use SynapsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, personal_number: nil, loading: false, resp: nil, ref: nil, error: false)}
  end

  def handle_event("sign", %{"personal_number" => pnumb}, socket) do
    case ExBankID.sign("1.1.1.1", "Tjobre sign pls", personal_number: pnumb, user_non_visible_data: "troll") do
      {:ok, sign} ->
        {:noreply, assign(socket, resp: sign, ref: sign.orderRef, error: false)}
      _ ->
        {:noreply, assign(socket, error: true)}
    end
  end

  def handle_event("collect", %{"personal_number" => pnumb}, socket) do
    case ExBankID.sign("1.1.1.1", "Tjobre sign pls", personal_number: pnumb, user_non_visible_data: "troll") do
      {:ok, sign} ->
        {:noreply, assign(socket, resp: sign, ref: sign.orderRef, error: false)}
      _ ->
        {:noreply, assign(socket, error: true)}
    end
  end
end
