defmodule AOC.Day3A do
  def get_input(:debug) do
    File.read!("day3_a_input0.txt")
    |> String.split("\n")
  end

  def get_input() do
    IO.read(:stdio, :all)
    |> String.split("\n")
  end

  def get_matrix do
    if Enum.at(System.argv(), 0) do
      get_input(:debug)
    else
      get_input()
    end
    |> Enum.map(&Enum.filter(String.split(&1, ""), fn x -> x != "" end))
    |> Enum.filter(&(&1 != []))
  end

  def check_array_is_symbol(array, matrix) do
    array
    |> Enum.map(fn [x, y] -> Enum.at(Enum.at(matrix, y, []), x, ".") end)
    |> Enum.map(fn x -> String.match?(x, ~r/[^\d.]/) end)
    |> Enum.reduce(&(&1 || &2))
  end

  def get_number(matrix, x, y, width) when x >= width do
    ["", false]
  end

  def get_number(matrix, x, y, width) do
    pos = Enum.at(Enum.at(matrix, y), x)

    has_neighbor =
      [[x, y - 1], [x, y + 1]]
      |> check_array_is_symbol(matrix)

    if String.match?(pos, ~r/\d/) do
      [num, has_n] = get_number(matrix, x + 1, y, width)
      [pos <> num, has_neighbor || has_n]
    else
      ["", has_neighbor || String.match?(pos, ~r/[^\d.]/)]
    end
  end

  def check_matrix(matrix, x, y, width, height) when y >= height do
    0
  end

  def check_matrix(matrix, x, y, width, height) when x >= width do
    check_matrix(matrix, 0, y + 1, width, height)
  end

  def check_matrix(matrix, x, y, width, height) do
    num = Enum.at(Enum.at(matrix, y), x)
    isNumber = String.match?(num, ~r/\d/)
    isLeftNumber = String.match?(Enum.at(Enum.at(matrix, y), x - 1), ~r/\d/)

    # IO.inspect(num)
    # IO.inspect(isNumber)
    # IO.inspect(isLeftNumber)

    hasNeighborLeft =
      [[x - 1, y - 1], [x - 1, y], [x - 1, y + 1]]
      |> check_array_is_symbol(matrix)

    if isNumber && not isLeftNumber do
      [char_num, hasNeighborOnTheRest] = get_number(matrix, x, y, width)

      # IO.inspect(char_num)
      # IO.inspect(has_neighbor)

      if hasNeighborLeft || hasNeighborOnTheRest do
        {parsed, _} = Integer.parse(char_num)

        parsed +
          check_matrix(matrix, x + String.length(char_num), y, width, height)
      else
        check_matrix(matrix, x + String.length(char_num), y, width, height)
      end
    else
      check_matrix(matrix, x + 1, y, width, height)
    end
  end

  def solve do
    matrix = get_matrix()
    width = Enum.count(Enum.at(matrix, 0))
    height = Enum.count(matrix)

    # IO.inspect(matrix)
    # IO.inspect(width)
    # IO.inspect(height)

    check_matrix(matrix, 0, 0, width, height)
    |> IO.inspect()
  end
end

AOC.Day3A.solve()
