defmodule GamedropWeb.PageController do
  use GamedropWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def admin(conn, _params) do
    render(conn, :admin)
  end
end
