#!/usr/bin/env elixir

defmodule Day7 do
  @moduledoc """
    --- Day 7: The Treachery of Whales ---
    https://adventofcode.com/2021/day/7
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
    |> Stream.flat_map(&String.split(&1, ","))
    |> Stream.map(&String.to_integer/1)
  end

  def part_one() do
    locations = 
      input_stream()
      |> Enum.to_list()

    {min, max} = Enum.min_max(locations)

    Enum.map(min..max, fn pivot ->
      Enum.reduce(locations, 0, fn location, acc ->
        acc + Kernel.abs(location - pivot)
      end)
    end)
    |> Enum.min()
  end

  def part_two() do
    input_stream()
  end
end

Day7.main()
