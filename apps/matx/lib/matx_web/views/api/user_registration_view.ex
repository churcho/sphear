defmodule MatxWeb.Api.UserRegistrationView do
  use MatxWeb, :view

  def render("show.json", data) do
    %{
      success: 
      %{
        token: data.token, email: data.email
        }
      }
  end

  def render("error.json", %{changeset: changeset}) do
    %{
      error: 
      %{
        errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
      }
    }
  end
end


