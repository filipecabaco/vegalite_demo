defmodule VegaliteDemoWeb.GraphLiveTest do
  use VegaliteDemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import VegaliteDemo.DemoFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_graph(_) do
    graph = graph_fixture()
    %{graph: graph}
  end

  describe "Index" do
    setup [:create_graph]

    test "lists all graphs", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.graph_index_path(conn, :index))

      assert html =~ "Listing Graphs"
    end

    test "saves new graph", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.graph_index_path(conn, :index))

      assert index_live |> element("a", "New Graph") |> render_click() =~
               "New Graph"

      assert_patch(index_live, Routes.graph_index_path(conn, :new))

      assert index_live
             |> form("#graph-form", graph: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#graph-form", graph: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.graph_index_path(conn, :index))

      assert html =~ "Graph created successfully"
    end

    test "updates graph in listing", %{conn: conn, graph: graph} do
      {:ok, index_live, _html} = live(conn, Routes.graph_index_path(conn, :index))

      assert index_live |> element("#graph-#{graph.id} a", "Edit") |> render_click() =~
               "Edit Graph"

      assert_patch(index_live, Routes.graph_index_path(conn, :edit, graph))

      assert index_live
             |> form("#graph-form", graph: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#graph-form", graph: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.graph_index_path(conn, :index))

      assert html =~ "Graph updated successfully"
    end

    test "deletes graph in listing", %{conn: conn, graph: graph} do
      {:ok, index_live, _html} = live(conn, Routes.graph_index_path(conn, :index))

      assert index_live |> element("#graph-#{graph.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#graph-#{graph.id}")
    end
  end

  describe "Show" do
    setup [:create_graph]

    test "displays graph", %{conn: conn, graph: graph} do
      {:ok, _show_live, html} = live(conn, Routes.graph_show_path(conn, :show, graph))

      assert html =~ "Show Graph"
    end

    test "updates graph within modal", %{conn: conn, graph: graph} do
      {:ok, show_live, _html} = live(conn, Routes.graph_show_path(conn, :show, graph))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Graph"

      assert_patch(show_live, Routes.graph_show_path(conn, :edit, graph))

      assert show_live
             |> form("#graph-form", graph: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#graph-form", graph: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.graph_show_path(conn, :show, graph))

      assert html =~ "Graph updated successfully"
    end
  end
end
