defmodule Db.Bookings do
  @moduledoc """
  The Bookings context.
  """

  import Ecto.Query, warn: false
  alias Db.Repo

  alias Db.Bookings.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  def list_categories_select do
    query = from(c in Category, select: {c.name, c.id})
    Repo.all(query)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias Db.Bookings.Mission

  @doc """
  Returns the list of missions.

  ## Examples

      iex> list_missions()
      [%Mission{}, ...]

  """
  def list_missions do
    Repo.all(Mission)
    |> Repo.preload(:category)
  end

  @doc """
  Gets a single mission.

  Raises `Ecto.NoResultsError` if the Mission does not exist.

  ## Examples

      iex> get_mission!(123)
      %Mission{}

      iex> get_mission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mission!(id), do: Repo.get!(Mission, id)

  @doc """
  Creates a mission.

  ## Examples

      iex> create_mission(%{field: value})
      {:ok, %Mission{}}

      iex> create_mission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mission(attrs \\ %{}) do
    %Mission{}
    |> Mission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mission.

  ## Examples

      iex> update_mission(mission, %{field: new_value})
      {:ok, %Mission{}}

      iex> update_mission(mission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mission(%Mission{} = mission, attrs) do
    mission
    |> Mission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mission.

  ## Examples

      iex> delete_mission(mission)
      {:ok, %Mission{}}

      iex> delete_mission(mission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mission(%Mission{} = mission) do
    Repo.delete(mission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mission changes.

  ## Examples

      iex> change_mission(mission)
      %Ecto.Changeset{data: %Mission{}}

  """
  def change_mission(%Mission{} = mission, attrs \\ %{}) do
    Mission.changeset(mission, attrs)
  end

  alias Db.Bookings.Demo

  @doc """
  Returns the list of demo.

  ## Examples

      iex> list_demo()
      [%Demo{}, ...]

  """
  def list_demo do
    Repo.all(Demo)
  end

  @doc """
  Gets a single demo.

  Raises `Ecto.NoResultsError` if the Demo does not exist.

  ## Examples

      iex> get_demo!(123)
      %Demo{}

      iex> get_demo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_demo!(id), do: Repo.get!(Demo, id)

  @doc """
  Creates a demo.

  ## Examples

      iex> create_demo(%{field: value})
      {:ok, %Demo{}}

      iex> create_demo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_demo(attrs \\ %{}) do
    %Demo{}
    |> Demo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a demo.

  ## Examples

      iex> update_demo(demo, %{field: new_value})
      {:ok, %Demo{}}

      iex> update_demo(demo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_demo(%Demo{} = demo, attrs) do
    demo
    |> Demo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a demo.

  ## Examples

      iex> delete_demo(demo)
      {:ok, %Demo{}}

      iex> delete_demo(demo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_demo(%Demo{} = demo) do
    Repo.delete(demo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking demo changes.

  ## Examples

      iex> change_demo(demo)
      %Ecto.Changeset{data: %Demo{}}

  """
  def change_demo(%Demo{} = demo, attrs \\ %{}) do
    Demo.changeset(demo, attrs)
  end
end
