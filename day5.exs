#!/usr/bin/env elixir

defmodule Day5 do
  @moduledoc """
    --- Day 5: Hydrothermal Venture ---
    https://adventofcode.com/2021/day/5
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
    |> Stream.map(&String.split(&1, " -> "))
    |> Stream.map(fn parts ->
      Enum.map(parts, fn part ->
        String.split(part, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
    end)
    |> Enum.to_list()
  end

  def part_one() do
    valid_inputs = 
      input_stream()
      |> Enum.filter(fn line ->
        horizontal?(line) or vertical?(line)
      end)

    marked = Enum.reduce(valid_inputs, %{}, &mark/2)
    Enum.count(marked, fn {_point, count} -> count >= 2 end)
  end

  def part_two() do
    inputs = input_stream()

    marked = Enum.reduce(inputs, %{}, &mark/2)

    Enum.count(marked, fn {_point, count} -> count >= 2 end)
  end

  def mark([{x1, y1}, {x2, y2}], acc) when x1 == x2 do
    Enum.reduce(
      y1..y2,
      acc,
      fn y, acc ->
        Map.update(acc, {x1, y}, 1, &(&1 + 1))
      end
    )
  end

  def mark([{x1, y1}, {x2, y2}], acc) when y1 == y2 do
    Enum.reduce(
      x1..x2,
      acc,
      fn x, acc ->
        Map.update(acc, {x, y1}, 1, &(&1 + 1))
      end
    )
  end

  def mark([{x1, y1}, {x2, y2}], acc) do
    points = Enum.zip(x1..x2, y1..y2)
 
    Enum.reduce(
      points,
      acc,
      fn point, acc ->
        Map.update(acc, point, 1, &(&1 + 1))
    end)
  end

  defp horizontal?([{x1, _y1}, {x2, _y2}]) when x1 == x2, do: true 
  defp horizontal?([_, _]), do: false

  defp vertical?([{_x1, y1}, {_x2, y2}]) when y1 == y2, do: true 
  defp vertical?([_, _]), do: false
end

Day5.main()
