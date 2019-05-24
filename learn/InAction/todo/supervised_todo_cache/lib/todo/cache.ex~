defmodule Todo.Cache do
  use GenServer

  def init(_) do
    Todo.Database.start("/tmp/persist")
    {:ok, %{}}
  end

  def start() do
    GenServer.start(__MODULE__, nil)
  end

  def server_process(pid, todo_list_name) do
    GenServer.call(pid, {:server_process, todo_list_name})
  end

  def handle_call({:server_process, todo_list_name}, _, servers) do
    case Dict.fetch(servers, todo_list_name) do
      {:ok, server} ->
        {:reply, server, servers}
      :error ->
        {:ok, new_server} = Todo.Server.start(todo_list_name)
        {:reply, new_server, Dict.put(servers, todo_list_name, new_server)}
    end
  end
end
