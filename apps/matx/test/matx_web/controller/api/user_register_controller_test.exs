defmodule MatxWeb.Api.UserRegistrationControllerTest do
  use Matx.ConnCase, async: true
  import Db.AccountsFixtures

  describe "POST /register -" do
    test "REGISTER SUCCESS", %{conn: conn} do
      email = unique_user_email()

      conn =
        post(conn, ApiRoutes.api_user_registration_path(conn, :create), 
          %{"email" => email, "password" => valid_user_password(), "password_confirmation" => valid_user_password()}
        ) |> doc

      response = json_response(conn, 200)
      assert response["success"]
    end

    test "REGISTER FAIL", %{conn: conn} do
      conn =
        post(conn, ApiRoutes.api_user_registration_path(conn, :create), 
          %{"email" => "with spaces", "password" => "lol", "password_confirmation" => "lol"}
        ) |> doc

      response = json_response(conn, 200)
      assert response["error"]
    end
  end
end
