defmodule Todo.PoolSupervisor do
  use Supervisor

  def start_link(folder, pool_size) do
    IO.puts "Starting PoolSupervisor..."
    Supervisor.start_link(__MODULE__, {folder, pool_size})
  end

  def init({folder, pool_size}) do
    processes = for worker_id <- 1..pool_size do
      worker(Todo.DatabaseWorker, [folder, worker_id], id: {:database_worker, worker_id})
    end
    supervise(processes, strategy: :one_for_one)
  end
end
