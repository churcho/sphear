defmodule MatxWeb.Api.UserSessionView do
  use MatxWeb, :view

  def render("show.json", token) do
    %{success: %{token: token.token}}
  end

  def render("info.json", message) do
    %{success: message.message}
  end

  def render("error.json", message) do
    %{error: message.error_message}
  end
end


