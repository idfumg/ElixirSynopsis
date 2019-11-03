defmodule PlugExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: PlugExample.Worker.start_link(arg)
      # {PlugExample.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: PlugExample.Router, options: [port: cowboy_port()]},
    ]

    Logger.info("Starting application...")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port(), do: Application.get_env(:plug_example, :cowboy_port, 8080)
end
