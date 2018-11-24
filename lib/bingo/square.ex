defmodule Bingo.Square do

  @enforce_keys [:phrase, :points]
  defstruct [:phrase, :points, :marked_by]

  alias __MODULE__

  # change changeset
  def new(phrase, points) do
    %Square{phrase: phrase, points: points}
  end

  # takes data to change changeset
  def from_buzzword(%{phrase: phrase, points: points}) do
    Square.new(phrase, points)
  end

end
