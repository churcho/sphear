defmodule MatxWeb.Api.ProductExtraMenuView do
  use MatxWeb, :view
  alias MatxWeb.Api.{ProductExtraView, ProductExtraMenuView}
  alias Db.Merchandise

  def render("index.json", %{product_extra_menus: product_extra_menus}) do
    %{product_extra_menus: render_many(product_extra_menus, ProductExtraMenuView, "product_extra_menu.json")}
  end

  def render("show.json", %{product_extra_menu: product_extra_menu}) do
    render_one(product_extra_menu, ProductExtraMenuView, "product_extra_menu.json")
  end

  def render("product_extra_menu.json", %{product_extra_menu: pex}) do
    %{
      id: pex.id,
      product_id: pex.product_id,
      name: pex.name,
      hidden: pex.hidden,
      mandatory: pex.mandatory,
      pick_only_one: pex.pick_only_one,
      default_extra: pex.default_extra,
      inserted_at: pex.inserted_at,
      product_extras: render_many(pex.product_extras, ProductExtraView, "show.json")
    }
  end
end
