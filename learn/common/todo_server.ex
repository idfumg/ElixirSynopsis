defmodule TodoServer do
  def start do
    spawn(fn -> loop(TodoList.new) end)
  end

  def add(todo_server, new_entry) do
    send(todo_server, {:add, new_entry})
  end

  def get(todo_server, date) do
    send(todo_server, {:get, self, date})
    receive do
      {:todo_entries, entries} -> entries
    after 5000 ->
        {:error, :timeout}
    end
  end

  defp loop(todo_list) do
    new_todo_list = receive do
      message -> process_message(todo_list, message)
    end
    loop(new_todo_list)
  end

  defp process_message(todo_list, {:add, new_entry}) do
    TodoList.add(todo_list, new_entry)
  end

  defp process_message(todo_list, {:get, caller, date}) do
    send(caller, {:todo_entries, TodoList.get(todo_list, date)})
    todo_list
  end
end

defmodule TodoList do
  defstruct [auto_id: 1, entries: %{}]

  def new(entries \\ []) do
    Enum.reduce(entries, %TodoList{}, &(add(&2, &1)))
  end

  def add(%TodoList{entries: entries, auto_id: auto_id} = _todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, entry.id, entry)

    %TodoList{
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def get(%TodoList{entries: entries}, date = {_, _, _}) do
    entries
    |> Stream.filter(fn({_, entry}) -> date == entry.date end)
    |> Enum.map(fn({_, entry}) -> entry end)
  end

  def update(%TodoList{entries: entries} = todo_list, id, updater_fun) do
    case entries[id] do
      nil ->
        todo_list
      old_entry ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end
end
