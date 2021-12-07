defmodule Day1 do
  @moduledoc """
    Day 1: Sonar Sweep
    https://adventofcode.com/2021/day/1
  """

  def main() do
    IO.inspect(part_one(), label: "Part One")
    IO.inspect(part_two(), label: "Part Two")
  end

  defp input_stream() do
    File.stream!("./priv/input.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
  end

  def part_one() do
    input_stream()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(&increasing?/1)
  end

  def part_two() do
    input_stream()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(&sum_increasing?/1)
  end

  defp increasing?([lhs, rhs]) when rhs > lhs, do: true
  defp increasing?(_), do: false

  defp sum_increasing?([lhs, rhs]), do: Enum.sum(rhs) > Enum.sum(lhs)
  defp sum_increasing?(_), do: false
end
