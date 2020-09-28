defmodule Db.Merchandise.ProductExtraMenu do
  use Db.Schema
  import Ecto.Changeset
  import SphearUtils.Ecto.Changeset, only: [validate_one_of_present: 2]

  alias Db.Feeders.Menu
  alias Db.Merchandise.{Product, ProductExtra}

  schema "product_extra_menus" do
    field :name, :string
    field :mandatory, :boolean, default: false
    field :pick_only_one, :boolean, default: false
    field :default_extra, :integer
    field :hidden, :boolean, default: true
    
    belongs_to :product, Product, type: :binary_id
    belongs_to :menu, Menu, type: :binary_id
    has_many :product_extras, ProductExtra

    timestamps()
  end

  @doc false
  def changeset(product_extra_menu, attrs) do
    product_extra_menu
    |> cast(attrs, [:name, :mandatory, :pick_only_one, :default_extra, :product_id, :menu_id, :hidden])
    |> validate_required([:name])
    |> validate_one_of_present([:product_id, :menu_id])
  end

  def changeset_edit(product_extra_menu, attrs) do
    product_extra_menu
    |> cast(attrs, [:name, :mandatory, :pick_only_one, :default_extra, :hidden])
  end
end
  