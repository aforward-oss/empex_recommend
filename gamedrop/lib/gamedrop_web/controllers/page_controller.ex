defmodule GamedropWeb.PageController do
  use GamedropWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def admin(conn, _params) do
    conn
    |> put_layout(html: {GamedropWeb.Layouts, :admin})
    |> assign(:css_body_class, "bg-white md:bg-slate-800")
    |> render(:admin)
  end
end
