defmodule SynapsWeb.MissionLiveTest do
  use SynapsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Db.Bookings

  @create_attrs %{ends_at: "2010-04-17T14:00:00Z", starts_at: "2010-04-17T14:00:00Z", status: "some status"}
  @update_attrs %{ends_at: "2011-05-18T15:01:01Z", starts_at: "2011-05-18T15:01:01Z", status: "some updated status"}
  @invalid_attrs %{ends_at: nil, starts_at: nil, status: nil}

  defp fixture(:mission) do
    {:ok, mission} = Bookings.create_mission(@create_attrs)
    mission
  end

  defp create_mission(_) do
    mission = fixture(:mission)
    %{mission: mission}
  end

  describe "Index" do
    setup [:create_mission]

    test "lists all missions", %{conn: conn, mission: mission} do
      {:ok, _index_live, html} = live(conn, Routes.mission_index_path(conn, :index))

      assert html =~ "Listing Missions"
      assert html =~ mission.status
    end

    test "saves new mission", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.mission_index_path(conn, :index))

      assert index_live |> element("a", "New Mission") |> render_click() =~
               "New Mission"

      assert_patch(index_live, Routes.mission_index_path(conn, :new))

      assert index_live
             |> form("#mission-form", mission: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mission-form", mission: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mission_index_path(conn, :index))

      assert html =~ "Mission created successfully"
      assert html =~ "some status"
    end

    test "updates mission in listing", %{conn: conn, mission: mission} do
      {:ok, index_live, _html} = live(conn, Routes.mission_index_path(conn, :index))

      assert index_live |> element("#mission-#{mission.id} a", "Edit") |> render_click() =~
               "Edit Mission"

      assert_patch(index_live, Routes.mission_index_path(conn, :edit, mission))

      assert index_live
             |> form("#mission-form", mission: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mission-form", mission: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mission_index_path(conn, :index))

      assert html =~ "Mission updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes mission in listing", %{conn: conn, mission: mission} do
      {:ok, index_live, _html} = live(conn, Routes.mission_index_path(conn, :index))

      assert index_live |> element("#mission-#{mission.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mission-#{mission.id}")
    end
  end

  describe "Show" do
    setup [:create_mission]

    test "displays mission", %{conn: conn, mission: mission} do
      {:ok, _show_live, html} = live(conn, Routes.mission_show_path(conn, :show, mission))

      assert html =~ "Show Mission"
      assert html =~ mission.status
    end

    test "updates mission within modal", %{conn: conn, mission: mission} do
      {:ok, show_live, _html} = live(conn, Routes.mission_show_path(conn, :show, mission))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mission"

      assert_patch(show_live, Routes.mission_show_path(conn, :edit, mission))

      assert show_live
             |> form("#mission-form", mission: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#mission-form", mission: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mission_show_path(conn, :show, mission))

      assert html =~ "Mission updated successfully"
      assert html =~ "some updated status"
    end
  end
end
