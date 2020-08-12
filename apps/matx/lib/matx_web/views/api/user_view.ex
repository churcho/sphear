defmodule MatxWeb.Api.UserView do
  use MatxWeb, :view
  alias MatxWeb.Api.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      user_tokens: user.user_tokens,
      orders: user.orders,
      email: user.email
    }
  end
end
