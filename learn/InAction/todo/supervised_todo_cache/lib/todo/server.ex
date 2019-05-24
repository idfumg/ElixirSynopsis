defmodule Todo.Server do
  use GenServer

  def init(listname) do
    send(self, :real_init)
    {:ok, {listname, nil}}
  end

  def start_link(listname) do
    IO.puts "Starting todo server for #{listname}"
    GenServer.start_link(__MODULE__, listname, name: via_tuple(listname))
  end

  defp via_tuple(name) do
    {:via, Todo.ProcessRegistry, {:todo_server, name}}
  end

  def whereis(name) do
    Todo.ProcessRegistry.whereis_name({:todo_server, name})
  end

  def add(pid, new_entry) do
    GenServer.cast(pid, {:add, new_entry})
  end

  def get(pid, date) do
    GenServer.call(pid, {:get, date}, 1000)
  end

  def handle_cast({:add, new_entry}, {listname, state}) do
    new_state = Todo.List.add(state, new_entry)
    Todo.Database.store(listname, new_state)
    {:noreply, {listname, new_state}}
  end

  def handle_call({:get, date}, _, {listname, state}) do
    {:reply, Todo.List.get(state, date), {listname, state}}
  end

  def handle_info(:real_init, {listname, _}) do
    {:noreply, {listname, Todo.Database.get(listname) || Todo.List.new}}
  end
end
