defmodule SynapsWeb.DemoLiveTest do
  use SynapsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Db.Bookings

  @create_attrs %{email: "some email", message: "some message", name: "some name", phone: "some phone"}
  @update_attrs %{email: "some updated email", message: "some updated message", name: "some updated name", phone: "some updated phone"}
  @invalid_attrs %{email: nil, message: nil, name: nil, phone: nil}

  defp fixture(:demo) do
    {:ok, demo} = Bookings.create_demo(@create_attrs)
    demo
  end

  defp create_demo(_) do
    demo = fixture(:demo)
    %{demo: demo}
  end

  describe "Index" do
    setup [:create_demo]

    test "lists all demo", %{conn: conn, demo: demo} do
      {:ok, _index_live, html} = live(conn, Routes.demo_index_path(conn, :index))

      assert html =~ "Listing Demo"
      assert html =~ demo.email
    end

    test "saves new demo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.demo_index_path(conn, :index))

      assert index_live |> element("a", "New Demo") |> render_click() =~
               "New Demo"

      assert_patch(index_live, Routes.demo_index_path(conn, :new))

      assert index_live
             |> form("#demo-form", demo: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#demo-form", demo: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.demo_index_path(conn, :index))

      assert html =~ "Demo created successfully"
      assert html =~ "some email"
    end

    test "updates demo in listing", %{conn: conn, demo: demo} do
      {:ok, index_live, _html} = live(conn, Routes.demo_index_path(conn, :index))

      assert index_live |> element("#demo-#{demo.id} a", "Edit") |> render_click() =~
               "Edit Demo"

      assert_patch(index_live, Routes.demo_index_path(conn, :edit, demo))

      assert index_live
             |> form("#demo-form", demo: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#demo-form", demo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.demo_index_path(conn, :index))

      assert html =~ "Demo updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes demo in listing", %{conn: conn, demo: demo} do
      {:ok, index_live, _html} = live(conn, Routes.demo_index_path(conn, :index))

      assert index_live |> element("#demo-#{demo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#demo-#{demo.id}")
    end
  end

  describe "Show" do
    setup [:create_demo]

    test "displays demo", %{conn: conn, demo: demo} do
      {:ok, _show_live, html} = live(conn, Routes.demo_show_path(conn, :show, demo))

      assert html =~ "Show Demo"
      assert html =~ demo.email
    end

    test "updates demo within modal", %{conn: conn, demo: demo} do
      {:ok, show_live, _html} = live(conn, Routes.demo_show_path(conn, :show, demo))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Demo"

      assert_patch(show_live, Routes.demo_show_path(conn, :edit, demo))

      assert show_live
             |> form("#demo-form", demo: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#demo-form", demo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.demo_show_path(conn, :show, demo))

      assert html =~ "Demo updated successfully"
      assert html =~ "some updated email"
    end
  end
end
