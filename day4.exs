#!/usr/bin/env elixir

defmodule Day4 do
  @moduledoc """
    --- Day 4: Giant Squid ---
    https://adventofcode.com/2021/day/4
  """

  def main() do
    IO.inspect(part_one(), label: "Part One")
    IO.inspect(part_two(), label: "Part Two")
  end

  defp parse_input() do
    base = __MODULE__
     |> to_string()
     |> String.downcase()
     |> String.slice(String.length("Elixir.")..-1)

    input = File.stream!("./priv/#{base}.txt")
      |> Stream.map(&String.trim_trailing/1)

    moves = input
      |> Enum.take(1)
      |> hd()
      |> String.split(",")

    input = Stream.drop(input, 1)

    boards = Enum.to_list(input)
     |> Enum.filter(&byte_size(&1) > 0)
     |> Enum.chunk_every(5)
     |> Enum.map(&parse_board/1)

    {moves, boards}
  end

  def parse_board(rows) do
    rows = 
      rows
      |> Enum.map(fn row ->
        Enum.map(
        [
          String.slice(row, 0..1),
          String.slice(row, 3..4),
          String.slice(row, 6..7),
          String.slice(row, 9..10),
          String.slice(row, 12..13)
        ], &String.trim_leading/1)
      end)

    Enum.concat(rows, transpose(rows))
  end

  def part_one() do
    {moves, boards} = parse_input()

    loop_until_winner(boards, moves)
  end

  def part_two() do
    {moves, boards} = parse_input()

    loop_until_one_board_remaining(boards, moves)
  end

  defp loop_until_winner(boards, [move | moves]) do
    boards = Enum.map(boards, &make_move(&1, move))

    winner = Enum.find(boards, fn board -> winning_board?(board) end)

    if winner do
      score(winner, String.to_integer(move))
    else
      loop_until_winner(boards, moves)
    end
  end

  defp loop_until_one_board_remaining([original_board], [move | moves]) do
    new_board = make_move(original_board, move)

    if winning_board?(new_board) do
      score(new_board, String.to_integer(move))
    else
      loop_until_one_board_remaining([new_board], moves)
    end
  end

  defp loop_until_one_board_remaining(boards, [move | moves]) do
    boards = Enum.map(boards, &make_move(&1, move))
    boards = Enum.reject(boards, &winning_board?/1)

    loop_until_one_board_remaining(boards, moves)
  end

  defp make_move(board, move) do
    Enum.map(board, fn row ->
      Enum.reject(row, fn square -> square == move end)
    end)
  end

  defp winning_board?(board) do
    Enum.any?(board, fn row -> Enum.count(row) == 0 end)
  end

  defp score(board, move) do
    rows = Enum.take(board, 5)
    
    sum = 
      Enum.map(rows, fn row ->
        Enum.map(row, &String.to_integer/1)
        |> Enum.sum()
      end)
      |> Enum.sum()

    sum * move
  end

  defp transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
end

Day4.main()
