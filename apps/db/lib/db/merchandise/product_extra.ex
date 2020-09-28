defmodule Db.Merchandise.ProductExtra do
  use Db.Schema
  import Ecto.Changeset
  import SphearUtils.Ecto.Changeset, only: [validate_if_present: 2]

  alias Db.Merchandise.{Product, ProductExtraMenu}

  schema "product_extras" do
    field :new_name, :string
    field :new_price, Money.Ecto.Amount.Type
    field :hidden, :boolean, default: true

    belongs_to :product, Product, type: :binary_id
    belongs_to :product_extra_menu, ProductExtraMenu, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(product_extra, attrs) do
    product_extra
    |> cast(attrs, [:new_price, :new_name, :hidden, :product_id, :product_extra_menu_id, :hidden])
    |> validate_required(:product_extra_menu_id)
    |> assoc_constraint(:product_extra_menu)
    |> validate_if_present(:product_id)
  end

  def changeset_edit(product_extra, attrs) do
    product_extra
    |> cast(attrs, [:new_price, :new_name, :hidden, :product_id])
    |> validate_if_present(:product_id)
  end
end
