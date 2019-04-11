defmodule Game do
  @moduledoc """
  Game keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @random %{
    0 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0},
    1 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
    2 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
    3 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
    4 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}
  }

  def new_grid(map \\ @random) do
    Enum.reduce(0..(map_size(map) - 1), %{}, fn x, acc_x ->
      value =
        Enum.reduce(0..(map_size(map[x]) - 1), %{}, fn y, acc_y ->
          Map.put(acc_y, y, live_or_die(map, x, y))
        end)

      Map.put(acc_x, x, value)
    end)
  end

  def live_or_die(map, x, y) do
    # Enum.reduce((x - 1)..(x + 1), 0, fn i, acc_i ->
    #   value =
    #     Enum.reduce((y - 1)..(y + 1), 0, fn j, acc_j ->
    #       if i != x and j != y,
    #         do: neighbours_count(map[i][j], map[i][acc_j]),
    #         else: neighbours_count(0, map[i][acc_j])
    #     end)

    #   neighbours_count(acc_i, value)
    # end)
    # |> live_or_die(map[x][y])

    neighbours_count(0, map[x - 1][y - 1])
    |> neighbours_count(map[x][y - 1])
    |> neighbours_count(map[x + 1][y - 1])
    |> neighbours_count(map[x - 1][y])
    |> neighbours_count(map[x + 1][y])
    |> neighbours_count(map[x - 1][y + 1])
    |> neighbours_count(map[x][y + 1])
    |> neighbours_count(map[x + 1][y + 1])
    |> live_or_die(map[x][y])
  end

  def neighbours_count(count, nil), do: count
  def neighbours_count(nil, _), do: 0
  def neighbours_count(count, x), do: count + x

  def live_or_die(2, 1), do: 1
  def live_or_die(3, 1), do: 1
  def live_or_die(_, 1), do: 0
  def live_or_die(3, 0), do: 1
  def live_or_die(_, 0), do: 0
end
