defmodule BlippxWeb.PageLiveTest do
  use BlippxWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "blippx"
    assert render(page_live) =~ "blippx"
  end
end
