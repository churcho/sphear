defmodule Db.Feeders.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Feeders.Menu

  schema "restaurants" do
    field :address, :string
    field :name, :string
    field :url, :string
    field :menus_order, {:array, :id}, default: []

    has_many :menus, Menu

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :url, :address, :menus_order])
    |> validate_required([:name, :url, :address])
  end

  def changeset_menus_order(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:menus_order])
  end
end
