defmodule Game.Test do
  use ExUnit.Case

  describe "Game.new_grid" do
    test "returns the correct new generation grid" do
      blinker_1 = %{
        0 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0},
        1 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
        2 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
        3 => %{0 => 0, 1 => 0, 2 => 1, 3 => 0, 4 => 0},
        4 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}
      }

      blinker_2 = %{
        0 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0},
        1 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0},
        2 => %{0 => 0, 1 => 1, 2 => 1, 3 => 1, 4 => 0},
        3 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0},
        4 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}
      }

      assert Game.new_grid(blinker_1) == blinker_2
      assert Game.new_grid(blinker_2) == blinker_1
    end
  end
end
