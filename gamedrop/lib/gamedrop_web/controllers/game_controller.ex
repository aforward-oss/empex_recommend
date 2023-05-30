defmodule GamedropWeb.GameController do
  use GamedropWeb, :controller

  alias Gamedrop.Pos
  alias Gamedrop.Pos.Game

  def index(conn, _params) do
    games = Pos.list_games()
    render(conn, :index, games: games)
  end

  def new(conn, _params) do
    changeset = Pos.change_game(%Game{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"game" => game_params}) do
    case Pos.create_game(game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: ~p"/games/#{game}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Pos.get_game!(id)
    render(conn, :show, game: game)
  end

  def edit(conn, %{"id" => id}) do
    game = Pos.get_game!(id)
    changeset = Pos.change_game(game)
    render(conn, :edit, game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Pos.get_game!(id)

    case Pos.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: ~p"/games/#{game}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Pos.get_game!(id)
    {:ok, _game} = Pos.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: ~p"/games")
  end
end
