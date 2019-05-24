defmodule Todo.Server do
  use GenServer

  def init(_) do
    {:ok, Todo.List.new}
  end

  def start() do
    GenServer.start(Todo.Server, nil)
  end

  def add(pid, new_entry) do
    GenServer.cast(pid, {:add, new_entry})
  end

  def get(pid, date) do
    GenServer.call(pid, {:get, date}, 1000)
  end

  def handle_cast({:add, new_entry}, state) do
    {:noreply, Todo.List.add(state, new_entry)}
  end

  def handle_call({:get, date}, _, state) do
    {:reply, Todo.List.get(state, date), state}
  end
end

# {:ok, pid} = Todo.Server.start()
# Todo.Server.add(pid, %{date: {2013, 12, 19}, title: "Dentist"})
# Todo.Server.get(pid, {2013, 12, 19})
