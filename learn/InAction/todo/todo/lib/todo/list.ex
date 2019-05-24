defmodule Todo.List do
  defstruct [auto_id: 1, entries: %{}]

  def new(entries \\ []) do
    Enum.reduce(entries, %Todo.List{}, &(add(&2, &1)))
  end

  def add(%Todo.List{entries: entries, auto_id: auto_id} = _todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, entry.id, entry)

    %Todo.List{
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def get(%Todo.List{entries: entries}, date = {_, _, _}) do
    entries
    |> Stream.filter(fn({_, entry}) -> date == entry.date end)
    |> Enum.map(fn({_, entry}) -> entry end)
  end

  def update(%Todo.List{entries: entries} = todo_list, id, updater_fun) do
    case entries[id] do
      nil ->
        todo_list
      old_entry ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %Todo.List{todo_list | entries: new_entries}
    end
  end
end
