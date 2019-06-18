defmodule Timed do
  def timed(fun, args) do
    {time, result} = :timer.tc(fun, args)
    IO.puts "Time: #{time} mcs"
    IO.puts "Result: #{result}"
  end
end

Timed.timed(fn (x) -> x*x end, [100])
