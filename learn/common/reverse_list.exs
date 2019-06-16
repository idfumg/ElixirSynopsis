IO.inspect Enum.reduce([1,2,3], [], fn x, acc -> [x | acc] end)
