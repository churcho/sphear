defmodule MatxWeb.Api.TrollView do
  use MatxWeb, :view

  def render("info.json", message) do
    %{info: message.message}
  end

  def render("error.json", message) do
    %{error: message.error_message}
  end
end


