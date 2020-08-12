defmodule Db.Sales.CartItem do
  use Ecto.Schema
  import Ecto.Changeset
  import SphearUtils.Ecto.Changeset, only: [validate_one_of_present: 2, validate_one_or_none_of_present: 2]

  alias Db.Merchandise.Product
  alias Db.Merchandise.ProductExtra
  alias Db.Sales.Cart

  schema "cart_items" do
    field :quantity, :integer, default: 1
    field :price, Money.Ecto.Amount.Type

    belongs_to :cart, Cart
    belongs_to :product, Product
    belongs_to :product_extra, ProductExtra
    
    timestamps()
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:quantity, :price, :cart_id, :product_id, :product_extra_id])
    |> validate_required([:cart_id])
    |> assoc_constraint(:cart)
    |> validate_one_of_present([:product_id, :product_extra_id])
  end

  @doc false
  def changeset_edit(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:quantity, :price, :product_id, :product_extra_id])
    |> validate_one_or_none_of_present([:product_id, :product_extra_id])
  end
end
