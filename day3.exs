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
    |> Stream.map(&String.to_integer(&1, 2))
  end

  use Bitwise

  def part_one() do
    input = input_stream()

    list_size = Enum.count(input)

    gamma_bitstring =
      (11..0)
      |> Enum.map(fn bit ->
        ones_at_position = Enum.count(input, fn number ->
          (number &&& bsl(1, bit)) == bsl(1, bit)
        end)

        more_than_half?(ones_at_position, list_size)
      end)
      |> Enum.map(&Integer.to_string/1)

    epsilon_bitstring = Enum.map(gamma_bitstring, &flip/1)

    gamma = String.to_integer(Enum.join(gamma_bitstring), 2)
    epsilon = String.to_integer(Enum.join(epsilon_bitstring), 2)

    gamma * epsilon
  end

  def part_two() do
    input = input_stream()

    oxygen = filter_to_bit(input, 11, :popular)
    co2 = filter_to_bit(input, 11, :unpopular)

    oxygen * co2
  end

  def filter_to_bit([ item ], _bit, _), do: item

  def filter_to_bit(items, bit, :popular) do
    popular = popular_bit(items, bit)
    
    filter_to_bit(
      Enum.filter(items, fn item ->
        (item &&& bsl(1, bit)) == bsl(popular, bit)
      end),
      bit - 1,
      :popular
    )
  end

  def filter_to_bit(items, bit, :unpopular) do
    unpopular = unpopular_bit(items, bit)

    filter_to_bit(
      Enum.filter(items, fn item ->
        (item &&& bsl(1, bit)) == bsl(unpopular, bit)
      end),
      bit - 1,
      :unpopular
    )
  end

  def popular_bit(items, position) do
    list_size = Enum.count(items)

    ones_at_position = Enum.count(items, fn item ->
      (item &&& bsl(1, position)) == bsl(1, position)
    end)

    if ones_at_position >= list_size / 2 do
      1
    else
      0
    end
  end

  def unpopular_bit(items, position) do
    list_size = Enum.count(items)

    ones_at_position = Enum.count(items, fn item ->
      (item &&& bsl(1, position)) == bsl(1, position)
    end)    

    if ones_at_position >= list_size / 2 do
      0
    else
      1
    end
  end

  defp flip("0"), do: "1"
  defp flip("1"), do: "0"

  defp more_than_half?(count, length) when count >= length / 2, do: 1
  defp more_than_half?(_, _), do: 0
end

Day3.main()
