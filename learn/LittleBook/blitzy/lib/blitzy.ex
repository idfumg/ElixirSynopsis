defmodule Blitzy do
  use Application

  def start(_type, _args) do
    Blitzy.Supervisor.start_link(:ok)
  end

  def run(n_workers, url) when n_workers > 0 do
    worker_fun = fn -> Blitzy.Worker.start(url) end

    1..n_workers
    |> Enum.map(fn _ -> Task.async(worker_fun) end)
    |> Enum.map(&Task.await(&1, :infinity))
    |> parse_results
  end

  def parse_results(results) do
    {successes, _failures} = results |> Enum.split_with(fn x ->
      case x do
        {:ok, _} -> true
        _ -> false
      end
    end)

    total_workers = Enum.count(results)
    total_success = Enum.count(successes)
    total_failure = total_workers - total_success

    times = successes |> Enum.map(fn {:ok, time} -> time end)
    average_time = average(times)
    longest_time = Enum.max(times)
    shortest_time = Enum.min(times)

    IO.puts """
    Total workers:   : #{total_workers}
    Successful reqs  : #{total_success}
    Failed reqs      : #{total_failure}
    Average (msecs)  : #{average_time}
    Longest (msecs)  : #{longest_time}
    Shortest (msecs) : #{shortest_time}
    """
  end

  defp average(times) do
    sum = Enum.sum(times)
    if sum > 0 do
      sum / Enum.count(times)
    else
      0
    end
  end
end
