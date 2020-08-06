defmodule Db.Merchandise.ProductExtra do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Merchandise.{Product, ProductExtraMenu}

  schema "product_extras" do
    field :new_name, :string
    field :new_price, Money.Ecto.Amount.Type
    field :hidden, :boolean, default: true

    belongs_to :product, Product
    belongs_to :product_extra_menu, ProductExtraMenu

    timestamps()
  end

  @doc false
  def changeset(product_extra, attrs) do
    product_extra
    |> cast(attrs, [:new_price, :new_name, :hidden, :product_id, :product_extra_menu_id, :hidden])
    |> validate_required([:product_id, :product_extra_menu_id])
    |> assoc_constraint(:product_extra_menu)
    |> assoc_constraint(:product)
  end
end
