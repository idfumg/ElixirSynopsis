defmodule Timer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    schedule_work()
    {:ok, []}
  end

  def handle_info(:work, state) do
    IO.puts "Received :work message"
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 2 * 1000)
  end
end
