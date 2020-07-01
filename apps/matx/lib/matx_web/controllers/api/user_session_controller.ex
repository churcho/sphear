defmodule MatxWeb.Api.UserSessionController do
  use MatxWeb, :controller

  alias Db.Accounts
  alias MatxWeb.UserAuth

  def create(conn, %{"email" => email, "password" => password}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do      
      token = Base.encode64(UserAuth.generate_api_token(user), case: :mixed)
      render(conn, "show.json", token: token)
    else
      render(conn, "error.json", error_message: "Fel användarnamn eller lösenord")
    end
  end

  def create(conn, _) do
    render(conn, "error.json", error_message: "Förväntar mig email och password")
  end

  def delete(conn, _params) do
    conn
    |> UserAuth.logout_token()
    |> render("info.json", message: "Loggade ut")
  end
end
