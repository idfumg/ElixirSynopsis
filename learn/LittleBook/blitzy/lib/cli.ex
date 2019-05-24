# ./blitzy  -n [requests] [url]
use Mix.Config

defmodule Blitzy.CLI do
  require Logger

  def main(args) do
    Application.get_env(:blitzy, :master_node)
    |> Node.start

    Application.get_env(:blitzy, :slave_nodes)
    |> Enum.each(&Node.connect(&1))

    #:timer.sleep(100000);

    [node() | Node.list()]
    |> Enum.map(&Node.ping(&1))
    |> IO.inspect

    args
    |> parse_args
    |> process_options([node() | Node.list()])
  end

  defp parse_args(args) do
    OptionParser.parse(args, aliases: [n: :requests], strict: [requests: :integer])
  end

  defp process_options(options, nodes) do
    case options do
      {[requests: n], [url], []} ->
        do_requests(n, url, nodes)
      _ ->
        do_help()
    end
  end

  defp do_help do
    IO.puts """
    Usage:
    blitzy -n [requests] [url]

    Options:
    -n, [--requests] # number of requests

    Example:
    ./blitzy -n 100 http://ya.ru
    """
    System.halt(0)
  end

  defp do_requests(n, url, nodes) do
    Logger.info "Pummeling #{url} with #{n} requests"

    total_nodes = Enum.count(nodes)
    request_per_node = div(n, total_nodes)

    nodes
    |> Enum.flat_map(fn node ->
      1..request_per_node
      |> Enum.map(fn _ ->
        IO.puts "Running start function on node #{node}"
        Task.Supervisor.async({Blitzy.TasksSupervisor, node}, Blitzy.Worker, :start, [url])
      end)
    end)
    |> Enum.map(&Task.await(&1, :infinity))
    |> Blitzy.parse_results
  end
end
