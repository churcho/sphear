defmodule Db.Merchandise.ProductExtraMenu do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Merchandise.{Product, ProductExtra}

  schema "product_extra_menus" do
    field :name, :string
    field :mandatory, :boolean, default: false
    field :pick_only_one, :boolean, default: false
    field :default_extra, :integer
    
    belongs_to :product, Product
    has_many :product_extras, ProductExtra

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :mandatory, :pick_only_one, :default_extra, :product_id])
    |> validate_required([:name, :product_id])
    |> assoc_constraint(:product)
  end
end
  