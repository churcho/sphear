defmodule Matx.UserRegistrationControllerTest do
  use Matx.ConnCase, async: true

  import Db.AccountsFixtures

  describe "POST /users/register" do
    @tag :capture_log
    test "creates account and logs the user in", %{conn: conn} do
      email = unique_user_email()

      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{"email" => email, "password" => valid_user_password(), "password_confirmation" => valid_user_password()}
        })

      assert get_session(conn, :user_token)

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ email
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{"email" => "with spaces", "password" => "lol", "password_confirmation" => "lol"}
        })

      response = html_response(conn, 200)
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 5 character"
    end
  end
end
