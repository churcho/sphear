defmodule Matx.UserResetPasswordControllerTest do
  use Matx.ConnCase, async: true

  alias Db.Accounts
  alias Db.Repo
  import Db.AccountsFixtures

  setup do
    %{user: user_fixture()}
  end

  describe "POST /users/reset_password" do
    @tag :capture_log
    test "sends a new reset password token", %{conn: conn, user: user} do
      post(conn, Routes.user_reset_password_path(conn, :create), %{
        "user" => %{"email" => user.email}
      })

      assert Repo.get_by!(Accounts.UserToken, user_id: user.id).context == "reset_password"
    end

    test "does not send reset password token if email is invalid", %{conn: conn} do
      post(conn, Routes.user_reset_password_path(conn, :create), %{
        "user" => %{"email" => "unknown@example.com"}
      })

      assert Repo.all(Accounts.UserToken) == []
    end
  end

  describe "PUT /users/reset_password/:token" do
    setup %{user: user} do
      token =
        extract_user_token(fn url ->
          Accounts.deliver_user_reset_password_instructions(user, url)
        end)

      %{token: token}
    end

    test "resets password once", %{conn: conn, user: user, token: token} do
      conn =
        put(conn, Routes.user_reset_password_path(conn, :update, token), %{
          "user" => %{
            "password" => "new valid password",
            "password_confirmation" => "new valid password"
          }
        })

      refute get_session(conn, :user_token)
      assert Accounts.get_user_by_email_and_password(user.email, "new valid password")
    end
  end
end
