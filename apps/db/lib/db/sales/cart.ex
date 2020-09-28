defmodule Db.Sales.Cart do
  use Db.Schema
  import Ecto.Changeset

  alias Db.Accounts.User
  alias Db.Sales.CartItem
  alias Db.Sales.Discount

  schema "carts" do
    belongs_to :user, User, references: :id, type: :binary_id
    
    has_many :cart_items, CartItem
    has_many :discounts, Discount
    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> assoc_constraint(:user)
  end
end
