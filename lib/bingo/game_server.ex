defmodule Bingo.GameServer do
  use GenServer
  require Logger

  @timeout :timer.hours(1)

  # Client Interface

  def start_link(game_name, size) do
    GenServer.start_link(__MODULE,
                         {game_name, size},
                         name: via_tuple(game_name))
  end

  def summary(game_name) do
    GenServer.call(via_tuple(game_name), :summary)
  end

  def mark(game_name, phrase, player) do
    GenServer.call(via_tuple(game_name), {:mark, phrase, player})
  end

  # returns tuple used to register and lookup a g_s process by name
  def via_tuple(game_name) do
    {:via, Registry, {Bingo.GameRegistry, game_name}}
  end

  def game_pid(game_name) do
    game_name
    |> via_tuple()
    |> GenServer.whereis()
  end

  ###################
  # Server Callback #
  ###################

  def init(game_name, size) do
    buzzwords = Bingo.BuzzwordCache.get_buzzwords()

    game =
      case :ets.lookup(:games_table, game_name) do
        [] ->
          game = Bingo.Game.new(buzzwords, size)
          :ets.insert(:games_table, {game_name, game})

        [{^game_name, game}] ->
          game
      end

    Logger.info("Spawned game server process named '#{game_name}'.")

    {:ok, game, @timeout}
  end

end
