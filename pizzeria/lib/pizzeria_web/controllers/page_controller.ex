defmodule PizzeriaWeb.PageController do
  use PizzeriaWeb, :controller
  alias Pizzeria.{Analytics, Pos}
  alias Pizzeria.Ml.Predictor, as: ML

  def home(conn, params) do
    num_resis = num_resis(params)

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

  defp num_resis(%{"date" => date}), do: Pos.num_reservations_on(date)
  defp num_resis(_params), do: Pos.num_reservations_tonight()
end
