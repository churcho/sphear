defmodule Db.Feeders do
  @moduledoc """
  The Feeders context.
  """

  import Ecto.Query, warn: false
  alias Db.Repo

  alias Db.Feeders.Restaurant

  use EctoList.Context,
    list: Restaurant,
    repo: Repo,
    list_items_key: :menus,
    items_order_key: :menus_sequence

  @doc """
  Returns the list of restaurants.

  ## Examples

      iex> list_restaurants()
      [%Restaurant{}, ...]

  """
  def list_restaurants do
    Repo.all(Restaurant) |> Repo.preload(:menus)
  end

  @doc """
  Gets a single restaurant.

  Raises `Ecto.NoResultsError` if the Restaurant does not exist.

  ## Examples

      iex> get_restaurant(123)
      {:ok, %Restaurant{}}

      iex> get_restaurant(456)
      {:error, :not_found}

  """
  def get_restaurant(id) do
    case Repo.get(Restaurant, id) do
      nil -> 
        {:error, :not_found}
      restaurant -> 
        restaurant = Repo.preload(restaurant, :menus)
        {:ok, restaurant}
    end
  end

  @doc """
  Creates a restaurant.

  ## Examples

      iex> create_restaurant(%{field: value})
      {:ok, %Restaurant{}}

      iex> create_restaurant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_restaurant(attrs \\ %{}) do
    %Restaurant{}
    |> Restaurant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a restaurant.

  ## Examples

      iex> update_restaurant(restaurant, %{field: new_value})
      {:ok, %Restaurant{}}

      iex> update_restaurant(restaurant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_restaurant(%Restaurant{} = restaurant, attrs) do
    restaurant
    |> Restaurant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a restaurant.

  ## Examples

      iex> delete_restaurant(restaurant)
      {:ok, %Restaurant{}}

      iex> delete_restaurant(restaurant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_restaurant(%Restaurant{} = restaurant) do
    Repo.delete(restaurant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking restaurant changes.

  ## Examples

      iex> change_restaurant(restaurant)
      %Ecto.Changeset{data: %Restaurant{}}

  """
  def change_restaurant(%Restaurant{} = restaurant, attrs \\ %{}) do
    Restaurant.changeset(restaurant, attrs)
  end

  # Suggest restaurants based on prefix
  def suggest(""), do: []
  def suggest(prefix) do
    Enum.filter(list_restaurants(), &has_prefix?(&1, prefix))
  end

  defp has_prefix?(restaurant, prefix) do
    String.starts_with?(String.downcase(restaurant.name), String.downcase(prefix))
  end

  alias Db.Feeders.Menu

  @doc """
  Returns the list of menus.

  ## Examples

      iex> list_menus()
      [%Menu{}, ...]

  """
  def list_menus do
    Repo.all(Menu)
  end

  @doc """
  Gets a single menu.

  Raises `Ecto.NoResultsError` if the Menu does not exist.

  ## Examples

      iex> get_menu!(123)
      %Menu{}

      iex> get_menu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_menu!(id), do: Repo.get!(Menu, id)

  def get_menu(id) do
    case Repo.get(Menu, id) do
      nil -> {:error, :not_found}
      menu -> {:ok, menu}
    end
  end

  @doc """
  Creates a menu.

  ## Examples

      iex> create_menu(%{field: value})
      {:ok, %Menu{}}

      iex> create_menu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_menu(attrs \\ %{}) do
    %Menu{}
    |> Menu.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a menu.

  ## Examples

      iex> update_menu(menu, %{field: new_value})
      {:ok, %Menu{}}

      iex> update_menu(menu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_menu(%Menu{} = menu, attrs) do
    menu
    |> Menu.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a menu.

  ## Examples

      iex> delete_menu(menu)
      {:ok, %Menu{}}

      iex> delete_menu(menu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_menu(%Menu{} = menu) do
    Repo.delete(menu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking menu changes.

  ## Examples

      iex> change_menu(menu)
      %Ecto.Changeset{data: %Menu{}}

  """
  def change_menu(%Menu{} = menu, attrs \\ %{}) do
    Menu.changeset(menu, attrs)
  end

  ## Sequence of menu, Restaurant context
  @doc """
    Returns an `%Ecto.Changeset{}` for tracking menu sequence changes.

    ## Examples

      iex> change_menu_sequence(restaurant, menu_item, (index), :action)
      %Ecto.Changeset{%Restaurant{}}
  """
  def change_menu_sequence(restaurant, menu_item, index, :insert) do
    index = index + 1
    new_sequence = EctoList.ListItem.insert_at(restaurant.menus_sequence, menu_item, index)
    Restaurant.changeset_menus_sequence(restaurant, %{menus_sequence: new_sequence})
  end
  def change_menu_sequence(restaurant, menu_item, :lower) do
    new_sequence = EctoList.ListItem.move_lower(restaurant.menus_sequence, menu_item)
    Restaurant.changeset_menus_sequence(restaurant, %{menus_sequence: new_sequence})
  end
  def change_menu_sequence(restaurant, menu_item, :higher) do
    new_sequence = EctoList.ListItem.move_higher(restaurant.menus_sequence, menu_item)
    Restaurant.changeset_menus_sequence(restaurant, %{menus_sequence: new_sequence})
  end
  def change_menu_sequence(restaurant, menu_item, :to_bottom) do
    new_sequence = EctoList.ListItem.move_to_bottom(restaurant.menus_sequence, menu_item)
    Restaurant.changeset_menus_sequence(restaurant, %{menus_sequence: new_sequence})
  end
  def change_menu_sequence(restaurant, menu_item, :to_top) do
    new_sequence = EctoList.ListItem.move_to_top(restaurant.menus_sequence, menu_item)
    Restaurant.changeset_menus_sequence(restaurant, %{menus_sequence: new_sequence})
  end
end
