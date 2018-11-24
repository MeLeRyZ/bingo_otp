defmodule Bingo.Buzzwords do

  def read_buzzwords do
    "../../data/buzzwords.csv"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)  #removes empty lines
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [phrase, points] ->
        %{phrase: phrase, points: String.to_integer(points)}
    end)
  end

end
