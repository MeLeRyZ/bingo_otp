defmodule Bingo.Game do

  @enforce_keys [:squares]
  defstruct squares: nil, scores: %{}, winner: nil

  alias Bingo.{Buzzwords, Game, Square, BingoChecker}

  def new(size) when is_integer(size) do
    buzzwords = Buzzwords.read_buzzwords()
    Game.new(buzzwords, size)
  end

  def new(buzzwords, size) do
    squares =
      buzzwords
      |> Enum.shuffle()
      |> Enum.take(size * size)
      |> Enum.map(&Square.from_buzzword(&1))
      |>Enum.chunk_every(size)

    %Game{squares: squares}
  end

end
