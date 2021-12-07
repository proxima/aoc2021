#!/usr/bin/env elixir

defmodule Day3 do
  @moduledoc """
    --- Day 3: Binary Diagnostic ---
    https://adventofcode.com/2021/day/3
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
  end

  def part_one() do
    input_stream()
  end

  def part_two() do
    input_stream()
  end

end

Day3.main()
