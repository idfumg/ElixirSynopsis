defmodule PasswordLogger do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, "/tmp/password_logs", [])
  end

  def log_incorrect(pid, logtext) do
    GenServer.cast(pid, {:log, logtext})
  end

  def init(logfile) do
    {:ok, logfile}
  end

  def handle_cast({:log, logtext}, filename) do
    File.chmod!(filename, 0o755)
    {:ok, file} = File.open(filename, [:append])
    IO.binwrite(file, logtext <> "\n")
    File.close(file)
    {:noreply, filename}
  end
end
