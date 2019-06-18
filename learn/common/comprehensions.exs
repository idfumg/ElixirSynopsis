import Integer

# Use list
IO.inspect for x <- [1,2,3,4], do: x*x

# Use Keyword list
IO.inspect for {_k, v} <- [one: 1, two: 2, three: 3], do: v

# Create Keyword list from Map
IO.inspect for {k, v} <- %{"a" => 1, "b" => 2}, do: {k, v}

# Working with binaries
IO.inspect for <<c <- "hello">>, do: <<c>>

# Ignore not matched values
IO.inspect for {:one, v} <- [one: 1, two: 2, three: 3], do: {:one, v}

# Multiple generators (like nested loops)
IO.inspect for n <- 1..4, times <- 1..n, do: String.duplicate("*", times)

# Using filter in generators
IO.inspect for x <- 1..10, is_even(x), do: x

# Using multiple filters in generators
IO.inspect for x <- 1..20, is_even(x), rem(x, 3) == 0, do: x

# Create a Map from a Keyword list
IO.inspect for {k, v} <- [one: 1, two: 2, three: 3], into: %{}, do: {k, v}

# Create a String from a Binary
IO.inspect for c <- [72, 101, 108, 108, 111], into: "", do: <<c>>
