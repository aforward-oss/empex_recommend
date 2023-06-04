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
      value = Map.get(map, raw_value, -1) + 1
      missing_mode = Keyword.get(opts, :missing, :error)

      case {missing_mode, value} do
        {:error, 0} ->
          raise "Missing #{raw_value} in #{Enum.join(set, ", ")}"

        {:ignore, 0} ->
          Nx.broadcast(0, {num_categories})

        {:other, _} ->
          do_encode(value, Enum.to_list(0..num_categories))

        {_, value} ->
          do_encode(value, Enum.to_list(1..num_categories))
      end
    else
      do_encode(value, set)
    end
  end

  def multi_hot_encode(values, set), do: multi_hot_encode(values, set, [])

  def multi_hot_encode(nil, set, opts), do: multi_hot_encode([], set, opts)

  def multi_hot_encode([], set, opts) do
    num_categories = Enum.count(set)
    missing_mode = Keyword.get(opts, :missing, :ignore)

    case missing_mode do
      :error ->
        raise "No values provided, at least one of #{Enum.join(set, ", ")} expected"

      :ignore ->
        Nx.broadcast(0, {num_categories})

      :other ->
        Nx.concatenate([
          Nx.tensor(1),
          Nx.broadcast(0, {num_categories})
        ])
    end
  end

  def multi_hot_encode(values, set, opts) do
    values
    |> Enum.map(&one_hot_encode(&1, set, opts))
    |> Enum.reduce(fn t, ans -> Nx.add(ans, t) end)
  end

  defp do_encode(value, set) do
    Nx.equal(Nx.tensor(value), Nx.tensor(set))
  end
end
