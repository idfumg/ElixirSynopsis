defmodule Todo.Cache do
  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def start_link() do
    IO.puts "Starting Todo cache..."
    GenServer.start_link(__MODULE__, nil, name: :todo_cache)
  end

  def server_process(todo_list_name) do
    GenServer.call(:todo_cache, {:server_process, todo_list_name})
  end

  def handle_call({:server_process, todo_list_name}, _, servers) do
    case Dict.fetch(servers, todo_list_name) do
      {:ok, server} ->
        {:reply, server, servers}
      :error ->
        {:ok, new_server} = Todo.ServerSupervisor.start_child(todo_list_name)
        {:reply, new_server, Dict.put(servers, todo_list_name, new_server)}
    end
  end
end
