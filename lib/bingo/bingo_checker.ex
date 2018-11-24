defmodule Bingo.BingoChecker do

  def bingo?(squares) do
    possible_winning_square_sequences(squares)
    |> sequences_with_at_least_one_square_marked()
    |> Enum.map(&all_squares_marked_by_same_player?(&1))
    |> Enum.any?()
  end

  def possible_winning_square_sequences(squares) do
    squares ++  # rows
    transpose(squares) ++  # columns
    [left_diagonal_squares(squares), right_diagonal_squares(squares)]
  end

  def sequences_with_at_least_one_square_marked(squares) do
    Enum.reject(squares, fn sequence ->
      Enum.reject(sequence, &is_nil(&1.marked_by)) |> Enum.empty?()
    end)
  end

  def all_squares_marked_by_same_player?(squares) do
    first_square = Enum.at(squares, 0)

    Enum.all?(squares, fn s ->
      s.marked_by == first_square.marked_by
    end)
  end

  def transpose(squares) do
    squares
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def rotate_90_degrees(squares) do
    squares
    |> transpose()
    |> Enum.reverse()
  end

  def left_diagonal_squares(squares) do
    squares
    |> List.flatten()
    |> Enum.take_every(Enum.count(squares) + 1)
  end

  def right_diagonal_squares(squares) do
    squares
    |> rotate_90_degrees()
    |> left_diagonal_squares()
  end
end
