#!/usr/bin/env elixir

defmodule Day2 do
  @moduledoc """
    --- Day 2: Dive! ---
    https://adventofcode.com/2021/day/2
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
    |> Stream.map(&String.split(&1, " "))
    |> Stream.map(fn [direction, count] -> [direction, String.to_integer(count)] end)
  end

  def part_one() do
    {x, y} = input_stream()
      |> track_movements()

    x * y
  end

  def part_two() do
    {x, y, _aim} = input_stream()
      |> track_aim()

    x * y
  end

  def track_movements(input) do
    Enum.reduce(input, {0, 0}, fn instruction, acc ->
      _apply(instruction, acc)
    end)
  end

  def track_aim(input) do
    Enum.reduce(input, {0, 0, 0}, fn instruction, acc ->
      _apply(instruction, acc)
    end)
  end

  defp _apply(["forward", steps], {x, y}), do: {x + steps, y}
  defp _apply(["down", steps], {x, y}), do: {x, y + steps}
  defp _apply(["up", steps], {x, y}), do: {x, y - steps}
  defp _apply(["forward", steps], {x, y, aim}), do: {x + steps, y + aim * steps, aim}
  defp _apply(["down", steps], {x, y, aim}), do: {x, y, aim + steps}
  defp _apply(["up", steps], {x, y, aim}), do: {x, y, aim - steps}
end

Day2.main()
