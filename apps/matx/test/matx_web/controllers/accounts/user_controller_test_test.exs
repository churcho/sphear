defmodule MatxWeb.Accounts.UserControllerTestTest do
  @moduledoc """
    Ajust the tests conform your app configuration :)
  """

  @test_user_email "test@test.com"
  @test_user_password "test"

  @create_user_route "/user/new"
  @root_route "/"

  use MatxWeb.ConnCase, async: true

  setup do
    opts =
      Plug.Session.init(
        store: :cookie,
        key: "test_key",
        encryption_salt: "test_encryption_salt",
        signing_salt: "test_signing_salt",
        log: false,
        encrypt: false
      )

    session_conn =
      build_conn()
      |> Plug.Session.call(opts)
      |> fetch_session()
      |> fetch_flash()

    %{session_conn: session_conn}
  end

  @tag :skip
  describe "MatxWeb.Accounts.UserControllerTest.create/2" do
    test "when create succesfully, redirect to root path", %{
      session_conn: session_conn
    } do
      params = %{"user" => %{"email" => @test_user_email, "password" => @test_user_password}}

      conn =
        session_conn
        |> post(@create_user_route, params)

      assert Db.Repo.all(Db.Accounts.User) |> Enum.count == 1
      assert @root_route = redirected_to(conn, 302)
    end
  end
end
