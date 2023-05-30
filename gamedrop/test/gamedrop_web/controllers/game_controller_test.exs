defmodule GamedropWeb.GameControllerTest do
  use GamedropWeb.ConnCase

  import Gamedrop.PosFixtures

  @create_attrs %{console_name: "some console_name", description: "some description", developer: "some developer", difficulty: 42, game_name: "some game_name", gameplay_rating: 42, genre: "some genre", maturity_rating: "some maturity_rating", multiplayer: true, player_mode: "some player_mode", release_date: ~D[2023-05-28]}
  @update_attrs %{console_name: "some updated console_name", description: "some updated description", developer: "some updated developer", difficulty: 43, game_name: "some updated game_name", gameplay_rating: 43, genre: "some updated genre", maturity_rating: "some updated maturity_rating", multiplayer: false, player_mode: "some updated player_mode", release_date: ~D[2023-05-29]}
  @invalid_attrs %{console_name: nil, description: nil, developer: nil, difficulty: nil, game_name: nil, gameplay_rating: nil, genre: nil, maturity_rating: nil, multiplayer: nil, player_mode: nil, release_date: nil}

  describe "index" do
    test "lists all games", %{conn: conn} do
      conn = get(conn, ~p"/games")
      assert html_response(conn, 200) =~ "Listing Games"
    end
  end

  describe "new game" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/games/new")
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "create game" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/games", game: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/games/#{id}"

      conn = get(conn, ~p"/games/#{id}")
      assert html_response(conn, 200) =~ "Game #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/games", game: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "edit game" do
    setup [:create_game]

    test "renders form for editing chosen game", %{conn: conn, game: game} do
      conn = get(conn, ~p"/games/#{game}/edit")
      assert html_response(conn, 200) =~ "Edit Game"
    end
  end

  describe "update game" do
    setup [:create_game]

    test "redirects when data is valid", %{conn: conn, game: game} do
      conn = put(conn, ~p"/games/#{game}", game: @update_attrs)
      assert redirected_to(conn) == ~p"/games/#{game}"

      conn = get(conn, ~p"/games/#{game}")
      assert html_response(conn, 200) =~ "some updated console_name"
    end

    test "renders errors when data is invalid", %{conn: conn, game: game} do
      conn = put(conn, ~p"/games/#{game}", game: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Game"
    end
  end

  describe "delete game" do
    setup [:create_game]

    test "deletes chosen game", %{conn: conn, game: game} do
      conn = delete(conn, ~p"/games/#{game}")
      assert redirected_to(conn) == ~p"/games"

      assert_error_sent 404, fn ->
        get(conn, ~p"/games/#{game}")
      end
    end
  end

  defp create_game(_) do
    game = game_fixture()
    %{game: game}
  end
end
