defmodule Pizzeria.Analytics do
  alias Pizzeria.Repo
  alias Pizzeria.Ml.Predictor

  def predict_num_doughs(num_resi) do
    Predictor.predict(num_resi, :default)
  end

  def reservations_by_date() do
    Repo.run_sql("""
    SELECT count(date),
           date,
           trim(to_char(date, 'Day')) as day_of_week
    FROM
      (SELECT date(datetime) AS date
       FROM reservations) t
    GROUP BY date
    ORDER BY date;
    """)
    |> num_date_to_map()
  end

  def pizza_doughs_by_date() do
    Repo.run_sql("""
    SELECT count(date),
           date,
           trim(to_char(date, 'Day')) as day_of_week
    FROM
      (SELECT date(ordered_at) AS date
       FROM orders
       WHERE item_name = 'pizza') t
    GROUP BY date
    ORDER BY date;
    """)
    |> num_date_to_map()
  end

  defp num_date_to_map(%Postgrex.Result{rows: rows}) do
    Enum.map(rows, fn [num, date, day_of_week] ->
      %{num: num, date: date, day_of_week: day_of_week}
    end)
  end
end
