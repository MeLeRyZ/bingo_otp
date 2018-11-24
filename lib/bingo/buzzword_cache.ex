defmodule Bingo.BuzzwordCache do
  use GenServer

  @refresh_interval :timer.minutes(60)

  # Client Interface

  def start_link(_arg) do
    GenServer.start(__MODULE__,
                   :ok,
                   name: __MODULE__)
  end

  def get_buzzwords() do
    GenServer.call(__MODULE__, :get_buzzwords)
  end

  # Server Callbacks
  def init(:ok) do
    state = load_buzzwords()
    schedule_refresh()
    {:ok, state}
  end

  def handle_call(:get_buzzwords, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:refresh, _state) do
    state = load_buzzwords()
    schedule_refresh()
    {:noreply, state}
  end

  # Private f's

  defp load_buzzwords() do
    Bingo.Buzzwords.read_buzzwords()
  end

  defp schedule_refresh do
    Process.send_after(self(), :refresh, @refresh_interval)
  end

end
