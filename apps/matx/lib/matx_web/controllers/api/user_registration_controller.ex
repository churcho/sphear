defmodule MatxWeb.Api.UserRegistrationController do
  use MatxWeb, :controller

  alias Db.Accounts
  alias Db.Accounts.User
  alias MatxWeb.UserAuth

  def create(conn, user_params) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        token = Base.encode64(UserAuth.generate_api_token(user), case: :mixed)
        render(conn, "show.json", %{token: token, email: user.email})
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
end
