defmodule GamedropWeb.GameplayControllerTest do
  use GamedropWeb.ConnCase

  import Gamedrop.PosFixtures

  @create_attrs %{console_name: "some console_name", game_name: "some game_name", gameplay_types: ["option1", "option2"], rental_cost: "120.5", top_rated: true}
  @update_attrs %{console_name: "some updated console_name", game_name: "some updated game_name", gameplay_types: ["option1"], rental_cost: "456.7", top_rated: false}
  @invalid_attrs %{console_name: nil, game_name: nil, gameplay_types: nil, rental_cost: nil, top_rated: nil}

  describe "index" do
    test "lists all gameplays", %{conn: conn} do
      conn = get(conn, ~p"/gameplays")
      assert html_response(conn, 200) =~ "Listing Gameplays"
    end
  end

  describe "new gameplay" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/gameplays/new")
      assert html_response(conn, 200) =~ "New Gameplay"
    end
  end

  describe "create gameplay" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/gameplays", gameplay: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/gameplays/#{id}"

      conn = get(conn, ~p"/gameplays/#{id}")
      assert html_response(conn, 200) =~ "Gameplay #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/gameplays", gameplay: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gameplay"
    end
  end

  describe "edit gameplay" do
    setup [:create_gameplay]

    test "renders form for editing chosen gameplay", %{conn: conn, gameplay: gameplay} do
      conn = get(conn, ~p"/gameplays/#{gameplay}/edit")
      assert html_response(conn, 200) =~ "Edit Gameplay"
    end
  end

  describe "update gameplay" do
    setup [:create_gameplay]

    test "redirects when data is valid", %{conn: conn, gameplay: gameplay} do
      conn = put(conn, ~p"/gameplays/#{gameplay}", gameplay: @update_attrs)
      assert redirected_to(conn) == ~p"/gameplays/#{gameplay}"

      conn = get(conn, ~p"/gameplays/#{gameplay}")
      assert html_response(conn, 200) =~ "some updated console_name"
    end

    test "renders errors when data is invalid", %{conn: conn, gameplay: gameplay} do
      conn = put(conn, ~p"/gameplays/#{gameplay}", gameplay: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gameplay"
    end
  end

  describe "delete gameplay" do
    setup [:create_gameplay]

    test "deletes chosen gameplay", %{conn: conn, gameplay: gameplay} do
      conn = delete(conn, ~p"/gameplays/#{gameplay}")
      assert redirected_to(conn) == ~p"/gameplays"

      assert_error_sent 404, fn ->
        get(conn, ~p"/gameplays/#{gameplay}")
      end
    end
  end

  defp create_gameplay(_) do
    gameplay = gameplay_fixture()
    %{gameplay: gameplay}
  end
end
