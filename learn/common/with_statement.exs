defmodule Example do
  def fun1(i), do: {:ok, i + 1}
  def fun2(i), do: {:ok, i + 2}
  def fun3(i), do: {:ok, i + 3}
end

with {:ok, result1} <- Example.fun1(1),
     {:ok, result2} <- Example.fun2(result1),
     {:ok, result3} <- Example.fun3(result2) do
  IO.puts "#{result1} #{result2} #{result3}"
else
  {:error, error_msg} -> IO.puts "Error occured: #{error_msg}"
end
