defmodule AOC.Day2 do
  def get_input do
    File.read!("input/day2.txt")
    |> String.split("\n")
  end

  def is_cube_possible([n, "blue"]) do
    String.to_integer(n) <= 14
  end

  def is_cube_possible([n, "green"]) do
    String.to_integer(n) <= 13
  end

  def is_cube_possible([n, "red"]) do
    String.to_integer(n) <= 12
  end

  # ["1 red", "2 green", "3 blue"]
  def is_round_possible(round) do
    round
    |> Enum.map(&is_cube_possible(String.split(String.trim(&1), " ")))
    |> Enum.all?(fn x -> x == true end)
  end

  # ["1 red, 2 green, 3 blue", "1 red, 2 green, 3 blue"]
  def is_game_possible(games) do
    games
    |> Enum.map(&is_round_possible(String.split(String.trim(&1), ",")))
    # |> Enum.map(&is_cube_possible/1)
    |> Enum.all?(fn x -> x == true end)
  end

  def get_variables("") do
    nil
  end

  def get_variables(line) do
    [gametitle, games] = line |> String.split(":")
    [_head, gameid] = gametitle |> String.split(" ")
    gameid = String.to_integer(gameid)
    [gameid, games]
  end

  def get_variables(line, :part1) do
    [gameid, games] = get_variables(line)
    is_possible = is_game_possible(String.split(games, ";"))
    [gameid, is_possible]
  end

  def part1 do
    get_input()
    |> Enum.map(&get_variables(&1, :part1))
    |> Enum.filter(fn a -> a != nil end)
    |> Enum.filter(fn [_gameid, is_possible] -> is_possible == true end)
    |> Enum.map(fn [gameid, _is_possible] -> gameid end)
    |> Enum.sum()
    |> IO.inspect()
  end

  def part2 do
    get_input()
    |> Enum.map(fn line ->
      [_head | game] = String.split(line, ":")

      game
      |> Enum.map(fn game ->
        rounds =
          game
          |> String.split(";")
          |> Enum.map(fn round ->
            round
            |> String.split(",")
            |> Enum.map(&String.trim/1)
            |> Enum.map(fn cube ->
              [n, color] = String.split(cube, " ")
              [String.to_integer(n), color]
            end)
          end)

        rounds
        |> Enum.reduce(
          %{"red" => 0, "green" => 0, "blue" => 0},
          fn round, acc ->
            Enum.reduce(round, acc, fn [n, color], acc2 ->
              Map.update!(acc2, color, &max(&1, n))
            end)
          end
        )
      end)
      |> Enum.map(fn %{"red" => red, "green" => green, "blue" => blue} ->
        red * green * blue
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
    |> IO.inspect()
  end
end

AOC.Day2.part2()
