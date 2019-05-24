defmodule Chucky.Server do
  def start_link do
    GenServer.start_link(__MODULE__, [], [name: {:global, __MODULE__}])
  end

  def fact do
    GenServer.call({:global, __MODULE__}, :fact)
  end

  # callbacks

  def init([]) do
    :random.seed(:os.timestamp)
    {:ok, ["123", "234", "345", "456", "567", "678", "789", "890"]}
  end

  def handle_call(:fact, _from, facts) do
    random_fact = facts |> Enum.shuffle |> List.first
    {:reply, random_fact, facts}
  end
end
