defmodule KeyValueStore do
  use GenServer

  def init(_) do
    :timer.send_interval(5000, :cleanup)
    {:ok, %{}}
  end

  def handle_info(:cleanup, state) do
    IO.puts "Performing cleanup..."
    {:noreply, state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end
end

GenServer.start(KeyValueStore, nil, name: :some_alias)
