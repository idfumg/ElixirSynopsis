defmodule AsyncOtp do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def request(pid) do
    GenServer.call(pid, :request)
  end

  def init(_) do
    send(self(), :long_init)
    {:ok, nil}
  end

  def handle_info(:long_init, state) do
    :timer.sleep(300)
    {:noreply, state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end

  def handle_call(:request, from, state) do
    # spawn fn ->
    #   GenServer.reply(from, :result)
    # end
    GenServer.reply(from, :result)
    do_some_expensive_work()
    {:noreply, state}
  end

  defp do_some_expensive_work() do
    :timer.sleep(3_000)
  end
end
