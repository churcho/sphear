defmodule Db.Feeders.Restaurant do
  use Db.Schema
  import Ecto.Changeset

  alias Db.Feeders.Menu
  alias Db.Merchandise.Product

  schema "restaurants" do
    field :address, :string
    field :name, :string
    field :url, :string
    field :menus_sequence, {:array, :binary_id}, default: [], type: :binary_id
    field :hidden, :boolean, default: true

    has_many :menus, Menu
    has_many :unlisted_products, Product

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :url, :address, :menus_sequence, :hidden])
    |> validate_required([:name, :url, :address])
  end

  def changeset_menus_sequence(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:menus_sequence])
  end
end
