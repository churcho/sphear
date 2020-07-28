defmodule MatxWeb.Api.ProductView do
  use MatxWeb, :view
  alias MatxWeb.Api.{ProductView, ProductExtraMenuView}
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
      restaurant_id: product.restaurant_id,
      name: product.name,
      price: Map.from_struct(product.price),
      price_to_string: Merchandise.price_to_string(product.price),
      inserted_at: product.inserted_at,
      hidden: product.hidden,
      product_extra_menus: render_many(product.product_extra_menus, ProductExtraMenuView, "show.json")
    }
  end

  def render("without_extra_menus.json", %{product: product}) do
    %{
      id: product.id,
      menu_id: product.menu_id,
      restaurant_id: product.restaurant_id,
      name: product.name,
      price: Map.from_struct(product.price),
      price_to_string: Merchandise.price_to_string(product.price),
      hidden: product.hidden,
      inserted_at: product.inserted_at
    }
  end
end
