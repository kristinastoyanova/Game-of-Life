defmodule Game do
  @random %{
    0 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0},
    1 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
    2 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
    3 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
    4 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}
  }

  @spec new_grid(map()) :: map()
  def new_grid(map \\ @random) do
    Enum.reduce(0..(map_size(map) - 1), %{}, fn x, acc_x ->
      value =
        Enum.reduce(0..(map_size(map[x]) - 1), %{}, fn y, acc_y ->
          Map.put(acc_y, y, live_or_die(map, x, y))
        end)

      Map.put(acc_x, x, value)
    end)
  end

  @spec live_or_die(map(), Integer.t(), Integer.t()) :: Integer.t()
  defp live_or_die(map, x, y) do
    neighbours_count(map, x, y)
    |> live_or_die(map[x][y])
  end

  @spec live_or_die(Integer.t(), Integer.t()) :: Integer.t()
  # 2 live neightbours + the currenct cell
  defp live_or_die(3, 1), do: 1
  # 3 live neightbours + the currenct cell
  defp live_or_die(4, 1), do: 1
  defp live_or_die(3, 0), do: 1
  defp live_or_die(_, _), do: 0

  @spec neighbours_count(map(), Integer.t(), Integer.t()) :: Integer.t()
  defp neighbours_count(map, x, y) do
    Enum.reduce((x - 1)..(x + 1), 0, fn i, acc ->
      value =
        map[i]
        |> case do
          nil -> 0
          map -> map |> Map.take((y - 1)..(y + 1)) |> Map.values() |> Enum.sum()
        end

      acc + value
    end)
  end
end
