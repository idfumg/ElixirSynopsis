defmodule BatchQueue do
  use GenServer

  def init(queue) do
    {:ok, queue}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, :queue.new())
  end

  def add(pid, item) do
    GenServer.cast(pid, {:add, item})
  end

  def list(pid) do
    GenServer.call(pid, :list)
  end

  def length(pid) do
    GenServer.call(pid, :length)
  end

  def fetch(pid) do
    GenServer.call(pid, :fetch)
  end

  def handle_cast({:add, item}, queue) do
    {:noreply, :queue.in(item, queue)}
  end

  def handle_call(:length, _from, queue) do
    {:reply, :queue.len(queue), queue}
  end

  def handle_call(:list, _from, queue) do
    {:reply, :queue.to_list(queue), queue}
  end

  def handle_call(:fetch, _from, queue) do
    case :queue.out(queue) do
      {{:value, item}, new_queue} -> {:reply, item, new_queue}
      {:empty, _} -> {:reply, :empty, queue}
    end
  end
end

{:ok, pid} = BatchQueue.start_link()
0 = BatchQueue.length(pid)
BatchQueue.add(pid, "item1")
BatchQueue.add(pid, "item2")
2 = BatchQueue.length(pid)
"item1" = BatchQueue.fetch(pid)
1 = BatchQueue.length(pid)
"item2" = BatchQueue.fetch(pid)
0 = BatchQueue.length(pid)
:empty = BatchQueue.fetch(pid)
