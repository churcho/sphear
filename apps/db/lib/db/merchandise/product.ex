defmodule Db.Merchandise.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Feeders.Menu

  schema "products" do
    field :name, :string
    field :price, Money.Ecto.Amount.Type
    
    belongs_to :menu, Menu

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :menu_id])
    |> validate_required([:name, :price, :menu_id])
    |> assoc_constraint(:menu)
  end
end
