defmodule MatxWeb.Api.CartView do
  use MatxWeb, :view
  alias MatxWeb.Api.CartView

  def render("index.json", %{carts: carts}) do
    %{carts: render_many(carts, CartView, "cart.json")}
  end

  def render("show.json", %{cart: cart}) do
    render_one(cart, CartView, "cart.json")
  end

  def render("cart.json", %{cart: cart}) do
    %{
      id: cart.id,
      cart_items: cart.cart_items,
      discounts: cart.discounts
    }
  end
end
