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

  defp input_map() do
    base = __MODULE__
     |> to_string()
     |> String.downcase()
     |> String.slice(String.length("Elixir.")..-1)

    File.stream!("./priv/#{base}.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.flat_map(&String.split(&1, ","))
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  def part_one() do
    input_map()
    |> simulate(80)
    |> Enum.reduce(0, fn {_age, count}, acc -> acc + count end) 
  end

  def part_two() do
    input_map()
    |> simulate(256)
    |> Enum.reduce(0, fn {_age, count}, acc -> acc + count end) 
  end

  def simulate(populace, 0), do: populace

  def simulate(populace, times) do
    populace = generation(populace)
    simulate(populace, times - 1)
  end

  def generation(populace) do
    Enum.reduce(populace, %{}, fn {age, count}, acc ->
      if age == 0 do
        Map.put(acc, 8, count)
        |> Map.update(6, count, &(&1 + count))
      else
        Map.update(acc, age - 1, count, &(&1 + count))
      end
    end)
  end
end

Day6.main()
