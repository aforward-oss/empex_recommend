defmodule Pizzeria.Analytics do
  alias Pizzeria.Repo

  def reservations_by_date(), do: reservations_by_date({nil, nil})

  def reservations_by_date(date_range) do
    {where, params} =
      case date_range do
        {nil, nil} ->
          {"", []}

        {start_date, end_date} ->
          {"WHERE date(datetime) BETWEEN $1 AND $2", [start_date, end_date]}
      end

    Repo.run_sql(
      """
      SELECT count(date),
             date,
             trim(to_char(date, 'Day')) as day_of_week
      FROM
        (SELECT date(datetime) AS date
         FROM reservations
         #{where}) t
      GROUP BY date
      ORDER BY date;
      """,
      params
    )
    |> num_date_to_map()
  end

  def pizza_doughs_by_date(), do: pizza_doughs_by_date({nil, nil})

  def pizza_doughs_by_date(date_range) do
    {where, params} =
      case date_range do
        {nil, nil} ->
          {"", []}

        {start_date, end_date} ->
          {"AND date(ordered_at) BETWEEN $1 AND $2", [start_date, end_date]}
      end

    Repo.run_sql(
      """
      SELECT count(date),
             date,
             trim(to_char(date, 'Day')) as day_of_week
      FROM
        (SELECT date(ordered_at) AS date
         FROM orders
         WHERE item_name = 'pizza' #{where}) t
      GROUP BY date
      ORDER BY date;
      """,
      params
    )
    |> num_date_to_map()
  end

  defp num_date_to_map(%Postgrex.Result{rows: rows}) do
    Enum.map(rows, fn [num, date, day_of_week] ->
      %{num: num, date: date, day_of_week: day_of_week}
    end)
  end
end
