defmodule PizzeriaWeb.PageController do
  use PizzeriaWeb, :controller
  alias Pizzeria.Analytics

  def home(conn, _params) do
    # hack this for demo purposesx
    num_resis = :rand.uniform(30) + 19

    conn
    |> assign(:reservations_by_date, Analytics.reservations_by_date())
    |> assign(:pizza_doughs_by_date, Analytics.pizza_doughs_by_date())
    |> assign(:num_resis_tonight, num_resis)
    |> assign(:num_doughs_predict, Analytics.predict_num_doughs(num_resis))
    |> render(:home)
  end
end
