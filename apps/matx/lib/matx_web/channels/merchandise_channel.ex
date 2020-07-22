defmodule MatxWeb.Channels.MerchandiseChannel do
  use Phoenix.Channel
  require Logger
  import MatxWeb.UserAuth

  alias Db.Merchandise
  alias Db.Feeders

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic
  Possible Return Values
  `{:ok, socket}` to authorize subscription for channel for requested topic
  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("merchandise:lobby", %{"token" => token}, socket) do
    case auth_token(socket, token) do
      {:ok, user} ->
        socket = assign(socket, :user_id, user.id)
        send(self(), :user_join)
        {:ok, socket}
      {:error, error_message} ->
        {:error, error_message}
    end
  end
  def join("merchandise:lobby", _, socket) do
    send(self(), :guest_join)
    {:ok, socket}
  end

  def handle_info(:user_join, socket) do
    push(socket, "lobby", %{login_success: true, user_id: socket.assigns[:user_id]})
    {:noreply, socket}
  end

  def handle_info(:guest_join, socket) do
    push(socket, "lobby", %{guest_success: true, user_id: nil})
    {:noreply, socket}
  end

  def handle_info(:ping, socket) do
    {:noreply, socket}
  end

  def handle_in("ping", _, socket) do
    {:reply, {:ok, %{message: "pong"}}, socket}
  end

  def handle_in("goodbye", _, socket) do
    {:stop, :normal, socket}
  end

  # # # # # # # # # #
  # P R O D U C T S #
  # # # # # # # # # #

  def handle_in("get_products", %{"menu_id" => id}, socket) do
    case Feeders.get_menu(id) do
      {:ok, menu} ->
        products = EctoList.ordered_items_list(menu.products, menu.products_sequence)
        {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "index.json", products: products)}}, socket}
      {:error, :not_found} ->
        {:reply, 
          {:error, %{message: "Could not find menu"}},
          socket}
    end
  end
  def handle_in("get_products", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'menu_id'"}},
    socket}
  end

  def handle_in("create_product", product_params, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Merchandise.create_product(product_params) do
          {:ok, product} ->
            MatxWeb.Endpoint.broadcast!("merchandise:lobby", "product_created", %{data: Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "show.json", product: product)})
            {:reply,
            {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "show.json", product: product)}},
            socket}
          {:error, %Ecto.Changeset{} = changeset} ->
            {:reply,
              {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
            socket}
        end
    end
  end

  def handle_in("delete_product", %{"product_id" => id}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Merchandise.get_product(id) do
          {:ok, product} ->
            {:ok, _} = Merchandise.delete_product(product)
            MatxWeb.Endpoint.broadcast!("merchandise:lobby", "product_deleted", %{message: "Deleted product '#{product.name}'", product_id: product.id})
            {:reply, 
              {:ok, %{message: "Deleted product '#{product.name}' with id #{product.id}"}}, 
              socket}
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find product with id: " <> id}},
              socket}
          end
      end
  end
  def handle_in("delete_product", _, socket) do
    {:reply, 
    {:error, %{message: "Missing 'product_id'"}},
    socket}
  end

  def handle_in("update_product", %{"product_id" => id, "params" => params}, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Merchandise.get_product(id) do
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find product with id: " <> id}},
              socket}
          {:ok, product} ->
            case Merchandise.update_product(product, params) do
              {:ok, product} ->
                MatxWeb.Endpoint.broadcast!("merchandise:lobby", "product_updated", %{data: Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "show.json", product: product)})
                {:reply, 
                  {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "show.json", product: product)}}, 
                  socket}
              {:error, %Ecto.Changeset{} = changeset} ->
                {:reply,
                  {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
                  socket}
            end
        end
    end
  end
  def handle_in("update_product", _, socket) do
    {:reply,
    {:error, %{message: "Missing 'product_id' or 'params'"}},
    socket}
  end

  def handle_in("change_product_sequence", %{"menu_id" => menu_id, "product_id" => product_id, "action" => "insert_at", "index" => index}, socket) do
    change_product_sequence(menu_id, product_id, "insert_at", index, socket)
  end
  def handle_in("change_product_sequence", %{"menu_id" => _menu_id, "product_id" => _product_id, "action" => "insert_at"}, socket) do
    {:reply,
    {:error, %{message: "Expected 'index' param when action is 'insert_at'"}},
    socket}
  end
  def handle_in("change_product_sequence", %{"menu_id" => menu_id, "product_id" => product_id, "action" => action}, socket) do
    change_product_sequence(menu_id, product_id, action, nil, socket)
  end
  def handle_in("change_product_sequence", _, socket) do
    {:reply,
    {:error, %{message: "Expected 'menu_id', 'product_id' and 'action' params"}},
    socket}
  end

  defp change_product_sequence(menu_id, product_id, action, index, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      _user_id ->
        case Feeders.get_menu(menu_id) do
          {:ok, menu} ->
            case changeset_product_sequence(menu, product_id, action, index) do
              {:ok, menu} ->
                products = EctoList.ordered_items_list(menu.products, menu.products_sequence)
                {:reply, {:ok, %{data: Phoenix.View.render_to_string(MatxWeb.Api.ProductView, "index.json", products: products)}}, socket}
              {:error, :action_not_found} ->
                {:reply,
                  {:error, %{message: "Unknown action"}},
                socket}
              {:error, %Ecto.Changeset{} = changeset} ->
                {:reply,
                  {:error, %{errors: Ecto.Changeset.traverse_errors(changeset, &MatxWeb.ErrorHelpers.translate_error/1)}},
                socket}
            end
          {:error, _} ->
            {:reply, 
              {:error, %{message: "Could not find menu with id: " <> menu_id}},
              socket}
        end
    end
  end

  defp changeset_product_sequence(menu, product_id, action, index) do
    case action do
      "higher" ->
        Merchandise.change_product_sequence(menu, product_id, :higher)
        |> Db.Repo.update()
      "lower" ->
        Merchandise.change_product_sequence(menu, product_id, :lower)
        |> Db.Repo.update()
      "to_top" ->
        Merchandise.change_product_sequence(menu, product_id, :to_top)
        |> Db.Repo.update()
      "to_bottom" ->
        Merchandise.change_product_sequence(menu, product_id, :to_bottom)
        |> Db.Repo.update()
      "insert_at" ->
        Merchandise.change_product_sequence(menu, product_id, index, :insert)
        |> Db.Repo.update()
      _ ->
        {:error, :action_not_found}
    end
  end

  ################

  def handle_in("logged_in", _, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:reply,
          {:error, %{message: "Unauthorized"}},
        socket}
      user_id ->
        {:reply, 
          {:ok, %{user_id: user_id}},
          socket}
    end
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end
end