defmodule Todo.SystemSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: :system_supervisor)
  end

  def init(_) do
    processes = [
      supervisor(Todo.Database, ["/tmp/persist"]),
      supervisor(Todo.ServerSupervisor, []),
      worker(Todo.Cache, [])
    ]
    supervise(processes, strategy: :one_for_one)
  end
end
