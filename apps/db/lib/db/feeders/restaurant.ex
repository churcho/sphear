defmodule Db.Feeders.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Feeders.Menu

  schema "restaurants" do
    field :address, :string
    field :name, :string
    field :url, :string
    field :menus_sequence, {:array, :id}, default: []

    has_many :menus, Menu

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :url, :address, :menus_sequence])
    |> validate_required([:name, :url, :address])
  end

  def changeset_menus_sequence(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:menus_sequence])
  end
end
