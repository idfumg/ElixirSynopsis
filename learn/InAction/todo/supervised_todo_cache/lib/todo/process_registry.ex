defmodule Todo.ProcessRegistry do
  import Kernel, except: [send: 2]

  use GenServer

  def start_link() do
    IO.puts "Starting ProcessRegistry"
    GenServer.start_link(__MODULE__, nil, name: :process_registry)
  end

  def init(_) do
    {:ok, %{}}
  end

  def register_name({type, worker_id}, worker_pid) do
    GenServer.call(:process_registry, {:register_name, {type, worker_id}, worker_pid})
  end

  def unregister_name({type, worker_id}) do
    GenServer.cast(:process_registry, {:unregister_name, {type, worker_id}})
  end

  def whereis_name({type, worker_id}) do
    GenServer.call(:process_registry, {:whereis_process, {type, worker_id}})
  end

  def send({_, _} = key, message) do
    case whereis_name(key) do
      :undefined ->
        {:badarg, {key, message}}
      pid ->
        Kernel.send(pid, message)
        pid
    end
  end

  def handle_call({:whereis_process, key}, _, processes) do
    {:reply, Dict.get(processes, key, :undefined), processes}
  end

  def handle_call({:register_name, key, pid}, _, processes) do
    case Dict.fetch(processes, key) do
      {:ok, _} ->
        {:reply, :no, processes}
      _ ->
        Process.monitor(pid)
        {:reply, :yes, Dict.put(processes, key, pid)}
    end

  end

  def handle_cast({:unregister_name, key}, processes) do
    {:noreply, Dict.delete(processes, key)}
  end

  def handle_info({:DOWN, _, :process, pid, _}, processes) do
    {:noreply, deregister_pid(processes, pid)}
  end

  defp deregister_pid(processes, pid) do
    map = for {key, value} <- processes, value == pid, into: %{}, do: {value, key}
    Map.delete(processes, map[pid])
  end
end
