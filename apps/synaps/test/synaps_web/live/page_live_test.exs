defmodule SynapsWeb.PageLiveTest do
  use SynapsWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Synapsus"
    assert render(page_live) =~ "Synapsus"
  end
end
