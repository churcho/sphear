defmodule MatxWeb.Api.CartItemView do
  use MatxWeb, :view
  alias MatxWeb.Api.CartItemView

  def render("index.json", %{cart_items: cart_items}) do
    %{cart_items: render_many(cart_items, CartItemView, "cart_items.json")}
  end

  def render("show.json", %{cart_item: cart_item}) do
    render_one(cart_item, CartItemView, "user.json")
  end

  def render("cart_item.json", %{cart_item: cart_item}) do
    %{
      id: cart_item.id,
      quantity: cart_item.quantity,
      price: cart_item.price,
      product: cart_item.product, 
      procut_extra: cart_item.product_extra
    }
  end
end
