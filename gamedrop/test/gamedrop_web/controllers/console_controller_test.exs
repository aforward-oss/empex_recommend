defmodule GamedropWeb.ConsoleControllerTest do
  use GamedropWeb.ConnCase

  import Gamedrop.PosFixtures

  @create_attrs %{company_name: "some company_name", company_website: "some company_website", console_name: "some console_name", release_date: ~D[2023-05-28]}
  @update_attrs %{company_name: "some updated company_name", company_website: "some updated company_website", console_name: "some updated console_name", release_date: ~D[2023-05-29]}
  @invalid_attrs %{company_name: nil, company_website: nil, console_name: nil, release_date: nil}

  describe "index" do
    test "lists all consoles", %{conn: conn} do
      conn = get(conn, ~p"/consoles")
      assert html_response(conn, 200) =~ "Listing Consoles"
    end
  end

  describe "new console" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/consoles/new")
      assert html_response(conn, 200) =~ "New Console"
    end
  end

  describe "create console" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/consoles", console: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/consoles/#{id}"

      conn = get(conn, ~p"/consoles/#{id}")
      assert html_response(conn, 200) =~ "Console #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/consoles", console: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Console"
    end
  end

  describe "edit console" do
    setup [:create_console]

    test "renders form for editing chosen console", %{conn: conn, console: console} do
      conn = get(conn, ~p"/consoles/#{console}/edit")
      assert html_response(conn, 200) =~ "Edit Console"
    end
  end

  describe "update console" do
    setup [:create_console]

    test "redirects when data is valid", %{conn: conn, console: console} do
      conn = put(conn, ~p"/consoles/#{console}", console: @update_attrs)
      assert redirected_to(conn) == ~p"/consoles/#{console}"

      conn = get(conn, ~p"/consoles/#{console}")
      assert html_response(conn, 200) =~ "some updated company_name"
    end

    test "renders errors when data is invalid", %{conn: conn, console: console} do
      conn = put(conn, ~p"/consoles/#{console}", console: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Console"
    end
  end

  describe "delete console" do
    setup [:create_console]

    test "deletes chosen console", %{conn: conn, console: console} do
      conn = delete(conn, ~p"/consoles/#{console}")
      assert redirected_to(conn) == ~p"/consoles"

      assert_error_sent 404, fn ->
        get(conn, ~p"/consoles/#{console}")
      end
    end
  end

  defp create_console(_) do
    console = console_fixture()
    %{console: console}
  end
end
