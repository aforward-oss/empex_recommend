defmodule GamedropWeb.PageController do
  use GamedropWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def admin(conn, _params) do
    all_game_names = Gamedrop.Pos.list_gameplays() |> Enum.map(& &1.game_name)

    conn
    |> assign(:all_game_names, all_game_names)
    |> render(:admin)
  end
end
