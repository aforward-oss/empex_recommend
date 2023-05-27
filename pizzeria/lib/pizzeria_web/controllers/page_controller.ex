defmodule PizzeriaWeb.PageController do
  use PizzeriaWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
