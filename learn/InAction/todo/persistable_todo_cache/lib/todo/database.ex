defmodule Todo.Database do
  use GenServer

  def start(folder) do
    GenServer.start(__MODULE__, folder, name: :database_server)
  end

  def store(key, data) do
    GenServer.cast(:database_server, {:store, key ,data})
  end

  def get(key) do
    GenServer.call(:database_server, {:get, key})
  end

  def init(folder) do
    File.mkdir_p(folder)
    {:ok, folder}
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
