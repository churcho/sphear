defmodule Db.Sales do
  @moduledoc """
  The Sales context.
  """

  import Ecto.Query, warn: false
  alias Db.Repo
  alias Db.Sales.{Cart, CartItem, Discount, Order}

  # # # # # #
  # C A R T #
  # # # # # #
  
  defp preload_cart({:ok, cart}) do
    cart =
      cart
      |> Repo.preload([:cart_items, :discounts])
    {:ok, cart}
  end
  defp preload_cart([cart]) do
    [cart]
    |> Repo.preload([:cart_items, :discounts])
  end
  defp preload_cart(error) do
    error
  end

  @doc """
  Gets a cart by id.

  {:ok, cart} if the Cart exist.
  {:error, :not_found} if the Cart does not exist.

  """

  def get_cart(id) do
    case Repo.get(Cart, id) do
      nil -> 
        {:error, :not_found}
      cart -> 
        {:ok, cart}
        |> preload_cart()
    end
  end

  @doc """
  Gets the latest cart by user_id.

  {:ok, cart} if the Cart exist.
  {:error, :not_found} if the Cart does not exist.

  """

  def get_latest_cart(id) do
    query =
      from(
        p in Cart,
        where: p.user_id == ^id,
        select: p,
        preload: [:cart_items, :discounts],
        order_by: [desc: p.inserted_at],
        limit: 1
      )
  
    Repo.one!(query)
  end

  @doc """
  Creates a Cart.

  ## Examples

      iex> create_cart(%{field: value})
      {:ok, %Cart{}}

      iex> create_cart(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
    |> preload_cart()
  end

  @doc """
  Updates a cart.

  ## Examples

      iex> update_cart(cart, %{field: new_value})
      {:ok, %Cart{}}

      iex> update_cart(cart, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cart(%Cart{} = cart, attrs) do
    cart
    |> Cart.changeset(attrs)
    |> Repo.update()
    |> preload_cart()
  end

  # # # # # # # # # #
  # C A R T I T E M #
  # # # # # # # # # #

  defp preload_cart_item({:ok, cart_item}) do
    cart_item =
      cart_item
      |> Repo.preload([:product, :product_extra])
    {:ok, cart_item}
  end
  defp preload_cart_item([cart_items]) do
    [cart_items]
    |> Repo.preload([:product, :product_extra])
  end
  defp preload_cart_item(error) do
    error
  end

  @doc """
  Gets a single cart item.

  {:ok, %CartItem{}}
  {:error, :not_found} if the Product Extra does not exist.

  ## Examples

      iex> get_cart_item(123)
      {:ok, %CartItem{}}

      iex> get_cart_item(456)
      {:error, :not_found}

  """
  def get_cart_item(id) do
    case Repo.get(CartItem, id) do
      nil -> 
        {:error, :not_found}
      cart_item -> 
        {:ok, cart_item}
        |> preload_cart_item()
    end
  end
  
  @doc """
  Creates a cart item.

  ## Examples

      iex> create_cart_item(%{field: value})
      {:ok, %CartItem{}}

      iex> create_cart_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart_item(attrs \\ %{}) do
    %CartItem{}
    |> CartItem.changeset(attrs)
    |> Repo.insert()
    |> preload_cart_item()
  end

  @doc """
  Updates a cart item.

  ## Examples

      iex> update_cart_item(cart_item, %{field: new_value})
      {:ok, %CartItem{}}

      iex> update_cart_item(cart_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cart_item(%CartItem{} = cart_item, attrs) do
    cart_item
    |> CartItem.changeset_edit(attrs)
    |> Repo.update()
    |> preload_cart_item()
  end

  @doc """
  Deletes a cart_item.

  ## Examples

      iex> delete_cart_item(cart_item)
      {:ok, %CartItem{}}

      iex> delete_cart_item(cart_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart_item(%CartItem{} = cart_item) do
    Repo.delete(cart_item)
  end

  # # # # # # #
  # O R D E R #
  # # # # # # #

  @doc """
  Gets a single order.

  {:ok, %Order{}}
  {:error, :not_found} if the Order does not exist.

  ## Examples

      iex> get_order(123)
      {:ok, %Order{}}

      iex> get_order(456)
      {:error, :not_found}

  """
  def get_order(id) do
    case Repo.get(Order, id) do
      nil -> 
        {:error, :not_found}
      order -> 
        {:ok, order}
    end
  end

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order state.

  ## Examples

      iex> update_order(order, %{state: new_state})
      {:ok, %Order{}}

      iex> update_order(order, %{state: bad_state})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset_edit(attrs)
    |> Repo.update()
  end

  # # # # # # # # # #
  # D I S C O U N T #
  # # # # # # # # # #

  @doc """
  Creates a discount.

  ## Examples

      iex> create_discount(%{cart_id: value, description: value})
      {:ok, %Discount{}}

      iex> create_discount(%{cart_id: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_discount(attrs \\ %{}) do
    %Discount{}
    |> Discount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a discount.

  ## Examples

      iex> update_discount(discount, %{field: new_value})
      {:ok, %Discount{}}

      iex> update_discount(discount, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_discount(%Discount{} = discount, attrs) do
    discount
    |> Discount.changeset_edit(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a discount.

  ## Examples

      iex> delete_discount(discount)
      {:ok, %Discount{}}

      iex> delete_discount(discount)
      {:error, %Ecto.Changeset{}}

  """
  def delete_discount(%Discount{} = discount) do
    Repo.delete(discount)
  end
end
