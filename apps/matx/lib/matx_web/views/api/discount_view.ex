defmodule MatxWeb.Api.DiscountView do
  use MatxWeb, :view
  alias MatxWeb.Api.UserView

  def render("index.json", %{discounts: discounts}) do
    %{discounts: render_many(discounts, DiscountView, "discount.json")}
  end

  def render("show.json", %{discount: discount}) do
    render_one(discount, UserView, "discount.json")
  end

  def render("discount.json", %{discount: discount}) do
    %{
      id: discount.id,
      flat_discount: discount.flat_discount,
      percentage_discount: discount.percentage_discount,
      description: discount.description
    }
  end
end
