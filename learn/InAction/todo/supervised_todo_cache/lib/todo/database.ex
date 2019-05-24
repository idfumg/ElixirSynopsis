defmodule Todo.Database do
  @pool_size 3

  def start_link(folder) do
    IO.puts "Starting Database..."
    Todo.PoolSupervisor.start_link(folder, @pool_size)
  end

  def init(folder) do
    File.mkdir_p(folder)
    {:ok, folder}
  end

  def store(key, data) do
    key
    |> choose_worker
    |> Todo.DatabaseWorker.store(key, data)
  end

  def get(key) do
    key
    |> choose_worker
    |> Todo.DatabaseWorker.get(key)
  end

  defp choose_worker(key) do
    :erlang.phash2(key, @pool_size) + 1
  end
end
