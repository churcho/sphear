defmodule MatxWeb.Api.UserSessionView do
  use MatxWeb, :view

  def render("show.json", token) do
    %{data: %{token: token.token}}
  end

  def render("info.json", message) do
    %{info: message.message}
  end

  def render("error.json", message) do
    %{error: message.error_message}
  end
end


