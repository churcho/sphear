defmodule MatxWeb.Api.UserSessionControllerTest do
  use Matx.ConnCase, async: true
  import Db.AccountsFixtures

  describe "POST /login -" do
    test "LOGIN SUCCESS", %{conn: conn} do
      {:ok, account} = user_fixture()

      conn =
        post(conn, ApiRoutes.api_user_session_path(conn, :create), 
          %{"email" => account.email, "password" => valid_user_password()}
        ) |> doc

      response = json_response(conn, 200)
      assert response["success"]
    end

    test "LOGIN FAIL", %{conn: conn} do
      {:ok, account} = user_fixture()

      conn =
        post(conn, ApiRoutes.api_user_session_path(conn, :create), 
          %{"email" => account.email, "password" => "lol"}
        ) |> doc

      response = json_response(conn, 200)
      assert response["error"]
    end
  end
end
