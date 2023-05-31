defmodule Tx do
  def category_encode(value, set, opts \\ []) do
    is_strict = Keyword.get(opts, :strict, true)
    index = Enum.find_index(set, &(&1 == value)) || -1

    if index == -1 && is_strict do
      raise "Missing #{value} in #{Enum.join(set, ", ")}"
    else
      Nx.tensor(index + 1)
    end
  end

  def one_hot_encode(value, set), do: one_hot_encode(value, set, [])

  def one_hot_encode(value, :digits, opts) do
    one_hot_encode(value, Enum.to_list(0..9), opts)
  end

  def one_hot_encode(value, set, opts) do
    if List.first(set) |> is_binary() do
      raw_value = value
      map = Enum.with_index(set) |> Enum.into(%{})
      num_categories = Enum.count(map)
      value = Map.get(map, value, -1) + 1
      is_strict = Keyword.get(opts, :strict, true)

      set =
        case {is_strict, value} do
          {true, 0} ->
            raise "Missing #{raw_value} in #{Enum.join(set, ", ")}"

          {true, _value} ->
            Enum.to_list(1..num_categories)

          {false, _value} ->
            Enum.to_list(0..num_categories)
        end

      do_encode(value, set)
    else
      do_encode(value, set)
    end
  end

  def multi_hot_encode(values, set), do: multi_hot_encode(values, set, [])

  def multi_hot_encode(values, set, opts) do
    values
    |> Enum.map(&one_hot_encode(&1, set, opts))
    |> Enum.reduce(fn t, ans -> Nx.add(ans, t) end)
  end

  defp do_encode(value, set) do
    Nx.equal(Nx.tensor(value), Nx.tensor(set))
  end
end
