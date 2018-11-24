defmodule BingoTest do
  use ExUnit.Case
  doctest Bingo

  test "greets the world" do
    assert Bingo.hello() == :world
  end
end
