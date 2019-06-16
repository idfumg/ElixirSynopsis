defmodule Example do
  def fun(), do: 1
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule ExampleTest do
      use ExUnit.Case

      import Example

      test "my code" do
        assert fun() == 1
      end
    end

  _ ->
    Example.fun() |> IO.puts
end
