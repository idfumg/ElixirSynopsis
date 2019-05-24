defmodule KeyValueStore do
  use GenServer # injects some code to the module

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Dict.put(state, key, value)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def start() do
    GenServer.start(KeyValueStore, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    timeout = 1000
    GenServer.call(pid, {:get, key}, timeout)
  end
end

KeyValueStore.__info__(:functions) # [code_change: 3, handle_call: 3, handle_cast: 2, handle_info: 2, init: 1, terminate: 2]

{:ok, pid} = KeyValueStore.start()
KeyValueStore.put(pid, :key, :value)
KeyValueStore.get(pid, :key) # :value
