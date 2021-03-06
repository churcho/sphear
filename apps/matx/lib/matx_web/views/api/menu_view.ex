defmodule MatxWeb.Api.MenuView do
  use MatxWeb, :view

  def render("index.json", %{menus: menus}) do
    %{menus: render_many(menus, MatxWeb.Api.MenuView, "menu.json")}
  end

  def render("show.json", %{menu: menu}) do
    render_one(menu, MatxWeb.Api.MenuView, "menu.json")
  end

  def render("menu.json", %{menu: menu}) do
    %{
      id: menu.id,
      restaurant_id: menu.restaurant_id,
      name: menu.name,
      hidden: menu.hidden,
      products: EctoList.ordered_items_list(render_many(menu.products, MatxWeb.Api.ProductView, "show.json"), menu.products_sequence),
      product_extra_menus: render_many(menu.product_extra_menus, MatxWeb.Api.ProductExtraMenuView, "show.json")
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
