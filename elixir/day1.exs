defmodule AOC.Day1 do
  def get_input do
    File.read!("input/day1.txt")
    |> String.split("\n")
  end

  def sub_num(num) do
    case num do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
      "zero" -> "0"
      _ -> num
    end
  end

  def sub_num_rev(num) do
    case num do
      "orez" -> "0"
      "enin" -> "1"
      "thgie" -> "2"
      "neves" -> "3"
      "xis" -> "4"
      "evif" -> "5"
      "ruof" -> "6"
      "eerht" -> "7"
      "owt" -> "8"
      "eno" -> "9"
      _ -> num
    end
  end

  def line_number(line) do
    Regex.run(~r/\d/, line)
    |> (fn a -> if a != nil, do: Enum.at(a, 0), else: "" end).()
  end

  def line_number(line, false) do
    Regex.run(~r/one|two|three|four|five|six|seven|eight|nine|zero|\d/, line)
    |> (fn a -> if a != nil, do: sub_num(Enum.at(a, 0)), else: "" end).()
  end

  def line_number(line, true) do
    Regex.run(~r/orez|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|\d/, line)
    |> (fn a -> if a != nil, do: sub_num_rev(Enum.at(a, 0)), else: "" end).()
  end

  def reduce_values(values) do
    values
    |> Enum.map(&Enum.join(&1))
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.to_integer(&1))
    |> Enum.map(&IO.puts(&1))

    # |> Enum.sum()
  end

  def part1 do
    get_input()
    |> Enum.map(&[line_number(&1), line_number(String.reverse(&1))])
    |> reduce_values()
    |> IO.puts()
  end

  def part2 do
    get_input()
    |> Enum.map(&[line_number(&1, false), line_number(String.reverse(&1), true)])
    |> reduce_values()
    |> IO.puts()
  end
end

AOC.Day1.part1()
AOC.Day1.part2()
