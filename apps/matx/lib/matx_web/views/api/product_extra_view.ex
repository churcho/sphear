defmodule MatxWeb.Api.ProductExtraView do
  use MatxWeb, :view
  alias MatxWeb.Api.{ProductView, ProductExtraView}
  alias Db.Merchandise

  def render("index.json", %{product_extras: product_extras}) do
    %{product_extras: render_many(product_extras, ProductExtraView, "product_extra.json")}
  end

  def render("show.json", %{product_extra: product_extra}) do
    render_one(product_extra, ProductExtraView, "product_extra.json")
  end

  def render("product_extra.json", %{product_extra: product_extra}) do
    %{
      id: product_extra.id,
      product_id: product_extra.product_id,
      product: render_one(product_extra.product, ProductView, "without_extra_menus.json"),
      product_extra_menu_id: product_extra.product_extra_menu_id,
      new_name: product_extra.new_name,
      new_price: Map.from_struct(product_extra.new_price),
      new_price_to_string: Merchandise.price_to_string(product_extra.new_price),
      inserted_at: product_extra.inserted_at,
      hidden: product_extra.hidden
    }
  end
end
