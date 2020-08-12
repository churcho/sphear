defmodule Db.Merchandise.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Feeders.{Restaurant, Menu}
  alias Db.Merchandise.{ProductExtra, ProductExtraMenu}

  schema "products" do
    field :name, :string
    field :price, Money.Ecto.Amount.Type
    field :hidden, :boolean, default: true
    
    belongs_to :restaurant, Restaurant
    belongs_to :menu, Menu
    has_many :product_extras, ProductExtra
    has_many :product_extra_menus, ProductExtraMenu
    
    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :menu_id, :hidden])
    |> validate_required([:name, :price, :menu_id])
    |> assoc_constraint(:menu)
  end

  @doc false
  def changeset_unlisted(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :restaurant_id, :hidden])
    |> validate_required([:name, :price, :restaurant_id])
    |> assoc_constraint(:restaurant)
  end

  def changeset_edit(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :hidden])
  end
end
