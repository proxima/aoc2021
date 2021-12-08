#!/usr/bin/env elixir

defmodule Day6 do
  @moduledoc """
    --- Day 6: Lanternfish ---
    https://adventofcode.com/2021/day/6
  """

  def main() do
    IO.inspect(part_one(), label: "Part One")
    IO.inspect(part_two(), label: "Part Two")
  end

  defp input_stream() do
    base = __MODULE__
     |> to_string()
     |> String.downcase()
     |> String.slice(String.length("Elixir.")..-1)

    File.stream!("./priv/#{base}.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.split(&1, ","))
  end

  def part_one() do
    input_stream()
    |> Enum.to_list()
  end

  def part_two() do
    input_stream()
  end

end

Day6.main()
