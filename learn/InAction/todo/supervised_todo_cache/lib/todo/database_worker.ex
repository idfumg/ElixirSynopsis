defmodule Todo.DatabaseWorker do
  use GenServer

  def start_link(folder, worker_id) do
    IO.puts "Starting the database worker #{worker_id}"
    GenServer.start_link(__MODULE__, folder, name: via_tuple(worker_id))
  end

  def store(worker_id, key, data) do
    GenServer.cast(via_tuple(worker_id), {:store, key, data})
  end

  def get(worker_id, key) do
    GenServer.call(via_tuple(worker_id), {:get, key})
  end

  defp via_tuple(worker_id) do
    {:via, Todo.ProcessRegistry, {:database_worker, worker_id}}
  end

  def handle_cast({:store, key, data}, folder) do
    spawn(fn ->
      "#{folder}/#{key}"
      |> File.write!(:erlang.term_to_binary(data))
    end)
    {:noreply, folder}
  end

  def handle_call({:get, key}, caller, folder) do
    spawn(fn ->
      data = case File.read("#{folder}/#{key}") do
               {:ok, contents} -> :erlang.binary_to_term(contents)
               _ -> nil
             end
      GenServer.reply(caller, data)
    end)
    {:noreply, folder}
  end
end
