#!/usr/bin/env elixir

defmodule Day8 do
  @moduledoc """
    --- Day 8: Seven Segment Search ---
    https://adventofcode.com/2021/day/8
  """

  def main() do
    IO.inspect(part_one(), label: "Part One")
    IO.inspect(part_two(), label: "Part Two")
  end

  # Example line
  # gbdfcae ebcg cfg gc facegb fecab acfge cbfgda fedag caebfd | ecbg bfcagd faegc gcf
  defp input_stream() do
    base = __MODULE__
     |> to_string()
     |> String.downcase()
     |> String.slice(String.length("Elixir.")..-1)

    File.stream!("./priv/#{base}.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.split(&1, " | "))
    |> Stream.map(fn [lhs, rhs] ->
        { String.split(lhs, " "), String.split(rhs, " ")  }
      end)
  end

  def part_one() do
    outputs = input_stream()
      |> Enum.map(fn {_lhs, rhs} -> rhs end)

    Enum.reduce(outputs, 0, fn x, acc ->
      acc + Enum.count(x, fn item -> byte_size(item) in [2, 3, 4, 7] end)
    end)
  end

  def part_two() do
    input_stream()
  end

end

Day8.main()
