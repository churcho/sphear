defmodule Db.Sales.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Accounts.User
  alias Db.Sales.CartItem
  alias Db.Sales.Discount

  schema "carts" do
    belongs_to :user, User
    
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
