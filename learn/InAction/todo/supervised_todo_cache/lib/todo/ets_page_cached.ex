defmodule EtsPageCached do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: :ets_page_cached)
  end

  def init(_) do
    :ets.new(:ets_page_cache, [:set, :named_table, :protected])
    {:ok, nil}
  end

  def cached(key, fun) do
    read_cached(key) || GenServer.call(:ets_page_cached, {:cached, key, fun})
  end

  def handle_call({:cached, key, fun}, _, state) do
    {:reply, read_cached(key) || cache_response(key, fun), state}
  end

  defp read_cached(key) do
    case :ets.lookup(:ets_page_cache, key) do
      [{^key, cached}] -> cached
      _ -> nil
    end
  end

  defp cache_response(key, fun) do
    response = fun.()
    :ets.insert(:ets_page_cache, {key, response})
    response
  end
end
