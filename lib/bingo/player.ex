defmodule Game.Player do
  @enforce_keys [:name, :color]
  defstruct [:name, :color]

  def new(name, color) do
    %Bingo.Player{name: name, color: color}
  end

end
