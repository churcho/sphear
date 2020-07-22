defmodule Db.Feeders.Menu do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Feeders.Restaurant
  alias Db.Merchandise.Product

  schema "menus" do
    field :name, :string
    field :products_sequence, {:array, :id}, default: []

    belongs_to :restaurant, Restaurant
    has_many :products, Product

    timestamps()
  end

  @doc false
  def changeset(menu, attrs) do
    menu
    |> cast(attrs, [:name, :restaurant_id, :products_sequence])
    |> validate_required([:name, :restaurant_id])
    |> assoc_constraint(:restaurant)
  end

  def changeset_products_sequence(menu, attrs) do
    menu
    |> cast(attrs, [:products_sequence])
  end
end
