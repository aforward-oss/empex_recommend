defmodule PizzeriaWeb.PageController do
  use PizzeriaWeb, :controller
  alias Pizzeria.Analytics
  alias Pizzeria.Ml.Predictor, as: ML

  def home(conn, _params) do
    # hack this for demo purposes
    num_resis = :rand.uniform(30) + 19

    conn
    |> assign(:num_resis_tonight, num_resis)
    |> assign(:num_doughs_predict, ML.predict(num_resis))
    |> render(:home)
  end

  def analytics(conn, _params) do
    conn
    |> assign(:reservations_by_date, Analytics.reservations_by_date())
    |> assign(:pizza_doughs_by_date, Analytics.pizza_doughs_by_date())
    |> render(:analytics)
  end
end
