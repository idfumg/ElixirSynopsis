defmodule Example do
  def fun(first_element, 0) do
    first_element
  end

  def fun(element, accumulator) do
    element + accumulator
  end
end

[1, 2, 3] |> Enum.reduce(0, &Example.fun/2) |> IO.puts
