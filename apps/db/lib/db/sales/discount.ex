defmodule Db.Sales.Discount do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Sales.Cart

  schema "discounts" do
    field :flat_discount, :integer, default: 0
    field :percentage_discount, :integer, default: 0
    field :description, :string

    belongs_to :cart, Cart
    timestamps()
  end

  @doc false
  def changeset(discount, attrs) do
    discount
    |> cast(attrs, [:cart_id, :flat_discount, :percentage_discount, :description])
    |> validate_required([:cart_id, :description])
    |> assoc_constraint(:cart)
  end

    @doc false
    def changeset_edit(discount, attrs) do
      discount
      |> cast(attrs, [:flat_discount, :percentage_discount, :description])
    end
end
