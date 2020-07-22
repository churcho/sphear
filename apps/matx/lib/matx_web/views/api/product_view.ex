defmodule MatxWeb.Api.ProductView do
  use MatxWeb, :view
  alias MatxWeb.Api.ProductView
  alias Db.Merchandise

  def render("index.json", %{products: products}) do
    %{products: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    render_one(product, ProductView, "product.json")
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      menu_id: product.menu_id,
      name: product.name,
      price: Map.from_struct(product.price),
      price_to_string: Merchandise.price_to_string(product),
      inserted_at: product.inserted_at
    }
  end
end
