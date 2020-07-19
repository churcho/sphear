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
      name: menu.name
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
