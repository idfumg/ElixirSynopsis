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

todo_list =
  TodoList.new
  |> TodoList.add(%{date: {2013, 12, 20}, title: "Mole"})
  |> TodoList.add(%{date: {2013, 12, 19}, title: "Dentist"})

list = [
  %{date: {2013, 12, 20}, title: "Mole"},
  %{date: {2013, 12, 19}, title: "Dentist"},
]
todo_list = TodoList.new(list)

TodoList.get(todo_list, {2013, 12, 19})
TodoList.update(todo_list, 2, fn(entry) -> %{entry | title: "Doctor"} end)

defmodule TodoList.CsvImporter do
  def import_file(filename) when is_binary(filename) do
    File.stream!(filename)
    |> Stream.map(fn(item) ->
      [date, title] = String.split(item, ",")
      [year, month, day] = String.split(date, "/")
      %{
        date: {
           String.to_integer(year),
           String.to_integer(month),
           String.to_integer(day)
        },
        title: String.strip(title)
      }
    end)
    |> TodoList.new
  end
end

defimpl String.Chars, for: TodoList do
  def to_string(thing) do
    "%TodoList{some_data}"
  end
end

todo_list = TodoList.CsvImporter.import_file("todos.csv")
IO.puts todo_list
