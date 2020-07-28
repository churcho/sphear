defmodule Db.Merchandise do
  @moduledoc """
  The Merchandise context.
  """

  import Ecto.Query, warn: false
  alias Db.Repo

  alias Db.Merchandise.{Product, ProductExtra, ProductExtraMenu}
  alias Db.Feeders.Menu

  use EctoList.Context,
    list: Menu,
    repo: Repo,
    list_items_key: :products,
    items_order_key: :products_sequence

  # # # # # # # # # #
  # P R O D U C T S #
  # # # # # # # # # #
  
  defp preload_products({:ok, product}) do
    product =
      product
      |> Repo.preload([product_extra_menus: [product_extras: :product]])
    {:ok, product}
  end
  defp preload_products(error) do
    error
  end

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
    |> Repo.preload([product_extra_menus: [product_extras: :product]])
  end

  @doc """
  Gets a single product.

  {:ok, product} if the Product exist.
  {:error, :not_found} if the Product does not exist.

  """

  def get_product(id) do
    case Repo.get(Product, id) do
      nil -> 
        {:error, :not_found}
      product -> 
        {:ok, product}
        |> preload_products()
    end
  end

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
    |> preload_products()
  end

  def create_unlisted_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset_unlisted(attrs)
    |> Repo.insert()
    |> preload_products()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
    |> preload_products()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def price_to_string(price) do
    String.replace(Money.to_string(price), ",00", "")
  end

  ## Sequence of products, Merchandise context
  @doc """
    Returns an `%Ecto.Changeset{}` for tracking product sequence changes.

    ## Examples

      iex> change_product_sequence(menu, product_item, (index), :action)
      %Ecto.Changeset{%Menu{}}
  """
  def change_product_sequence(menu, product_item, index, :insert) do
    index = index + 1
    new_sequence = EctoList.ListItem.insert_at(menu.products_sequence, product_item, index)
    Menu.changeset_products_sequence(menu, %{products_sequence: new_sequence})
  end
  def change_product_sequence(menu, product_item, :lower) do
    new_sequence = EctoList.ListItem.move_lower(menu.products_sequence, product_item)
    Menu.changeset_products_sequence(menu, %{products_sequence: new_sequence})
  end
  def change_product_sequence(menu, product_item, :higher) do
    new_sequence = EctoList.ListItem.move_higher(menu.products_sequence, product_item)
    Menu.changeset_products_sequence(menu, %{products_sequence: new_sequence})
  end
  def change_product_sequence(menu, product_item, :to_bottom) do
    new_sequence = EctoList.ListItem.move_to_bottom(menu.products_sequence, product_item)
    Menu.changeset_products_sequence(menu, %{products_sequence: new_sequence})
  end
  def change_product_sequence(menu, product_item, :to_top) do
    new_sequence = EctoList.ListItem.move_to_top(menu.products_sequence, product_item)
    Menu.changeset_products_sequence(menu, %{products_sequence: new_sequence})
  end

  # # # # # # # # # 
  # Product Extra #
  # # # # # # # # #

  defp preload_product_extras({:ok, product_extra}) do
    product_extra =
      product_extra
      |> Repo.preload(:product)
    {:ok, product_extra}
  end
  defp preload_product_extras(error) do
    error
  end

  @doc """
  Gets a single product extra.

  {:ok, %ProductExtra{}}
  {:error, :not_found} if the Product Extra does not exist.

  ## Examples

      iex> get_product_extra(123)
      {:ok, %ProductExtra{}}

      iex> get_product_extra(456)
      {:error, :not_found}

  """
  def get_product_extra(id) do
    case Repo.get(ProductExtra, id) do
      nil -> 
        {:error, :not_found}
      product_extra -> 
        {:ok, product_extra}
        |> preload_product_extras()
    end
  end
  
  @doc """
  Creates a product extra.

  ## Examples

      iex> create_product_extra(%{field: value})
      {:ok, %ProductExtra{}}

      iex> create_product_extra(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_extra(attrs \\ %{}) do
    %ProductExtra{}
    |> ProductExtra.changeset(attrs)
    |> Repo.insert()
    |> preload_product_extras()
  end

  @doc """
  Updates a product extra.

  ## Examples

      iex> update_product_extra(product_extra, %{field: new_value})
      {:ok, %ProductExtra{}}

      iex> update_product_extra(product_extra, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_extra(%ProductExtra{} = product_extra, attrs) do
    product_extra
    |> ProductExtra.changeset(attrs)
    |> Repo.update()
    |> preload_product_extras()
  end

  @doc """
  Deletes a product_extra.

  ## Examples

      iex> delete_product_extra(product_extra)
      {:ok, %ProductExtra{}}

      iex> delete_product_extra(product_extra)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_extra(%ProductExtra{} = product_extra) do
    Repo.delete(product_extra)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product extra changes.

  ## Examples

      iex> change_product_extra(product_extra)
      %Ecto.Changeset{data: %ProductExtra{}}

  """
  def change_product_extra(%ProductExtra{} = product_extra, attrs \\ %{}) do
    ProductExtra.changeset(product_extra, attrs)
  end

  # # # # # # # # # # # #
  # Product Extra Menu  #
  # # # # # # # # # # # #

  defp preload_product_extra_menus({:ok, product_extra_menu}) do
    product_extra_menu =
      product_extra_menu
      |> Repo.preload([product_extras: :product])
    {:ok, product_extra_menu}
  end
  defp preload_product_extra_menus(error) do
    error
  end

  @doc """
  Gets a single product extra menu.

  {:ok, %ProductExtraMenu{}}
  {:error, :not_found} if the Product Extra Menu does not exist.

  ## Examples

      iex> get_product_extra_menu(123)
      {:ok, %ProductExtraMenu{}}

      iex> get_product_extra_menu(456)
      {:error, :not_found}

  """
  def get_product_extra_menu(id) do
    case Repo.get(ProductExtraMenu, id) do
      nil -> 
        {:error, :not_found}
      product_extra_menu -> 
        {:ok, product_extra_menu}
        |> preload_product_extra_menus()
    end
  end

  @doc """
  Creates a product extra menu.

  ## Examples

      iex> create_product_extra_menu(%{field: value})
      {:ok, %ProductExtraMenu{}}

      iex> create_product_extra_menu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_extra_menu(attrs \\ %{}) do
    %ProductExtraMenu{}
    |> ProductExtraMenu.changeset(attrs)
    |> Repo.insert()
    |> preload_product_extra_menus()
  end

  @doc """
  Updates a product extra menu.

  ## Examples

      iex> update_product_extra_menu(product_extra_menu, %{field: new_value})
      {:ok, %ProductExtraMenu{}}

      iex> update_product_extra_menu(product_extra_menu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_extra_menu(%ProductExtraMenu{} = product_extra_menu, attrs) do
    product_extra_menu
    |> ProductExtraMenu.changeset(attrs)
    |> Repo.update()
    |> preload_product_extra_menus()
  end

  @doc """
  Deletes a product_extra_menu.

  ## Examples

      iex> delete_product_extra_menu(product_extra_menu)
      {:ok, %ProductExtraMenu{}}

      iex> delete_product_extra_menu(product_extra_menu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_extra_menu(%ProductExtraMenu{} = product_extra_menu) do
    Repo.delete(product_extra_menu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product extra menu changes.

  ## Examples

      iex> change_product_extra_menu(product_extra_menu)
      %Ecto.Changeset{data: %ProductExtraMenu{}}

  """
  def change_product_extra_menu(%ProductExtraMenu{} = product_extra_menu, attrs \\ %{}) do
    ProductExtraMenu.changeset(product_extra_menu, attrs)
  end
end
