# >>>> Basic arithmetic

IO.puts("1 + 1 = #{1 + 1}")
IO.puts("2 * 3 = #{2 * 3}")
IO.puts("3 / 2 = #{3 / 2}")
IO.puts("div 3, 2 = #{div 3, 2}")
IO.puts("rem 3, 2 = #{rem 3, 2}")
IO.puts("0b1010 = #{0b1010}")
IO.puts("0o777 = #{0o777}")
IO.puts("0x1F = #{0x1F}")
IO.puts("1.0 = #{1.0}")
IO.puts("1.0e-10 = #{1.0e-10}")
IO.puts("round(3.58) = #{round(3.58)}")
IO.puts("trunc(3.58) = #{trunc(3.58)}")

IO.puts(" ")

IO.puts("is_tuple {1, 2, 3} = #{is_tuple {1, 2, 3}}")
IO.puts("is_list [1, 2, 3] = #{is_list [1, 2, 3]}")
IO.puts("is_nil nil = #{is_nil nil}")
IO.puts("is_integer 1 = #{is_integer 1}")
IO.puts("is_float 1.0 = #{is_float 1.0}")
IO.puts("is_number 1.0 = #{is_number 1.0}")
IO.puts("is_atom :a = #{is_atom :a}")
IO.puts("is_boolean true = #{is_boolean true}")
IO.puts("is_binary 'qwe' = #{is_binary "qwe"}") # sequences of bytes

IO.puts(" ")

# >>>> Strings

IO.puts("Integer.to_string 3 = #{Integer.to_string 3}")
IO.puts('byte_size "hello" = #{byte_size "hello"}') # constant time
IO.puts('String.contains? "приветик!", "привет" =  #{String.contains? "приветик!", "привет"}')
IO.puts('String.contains? "приветик!", "покашки" =  #{String.contains? "приветик!", "покашки"}')
IO.puts('String.upcase "hello" = #{String.upcase "hello"}')
IO.puts('String.downcase "HELLO" = #{String.downcase "HELLO"}')
IO.puts('String.capitalize "привет" = #{String.capitalize "привет"}')
IO.puts('String.at "hello", 0 = #{String.at "hello", 0}')
IO.puts('"hello" <> "world" = #{"hello" <> "world"}') # string concatenation

IO.puts(" ")

# >>>> Functions

add = fn a, b -> a + b end
double = fn a -> add.(a, a) end
IO.puts('add.(1, 2) = #{add.(1, 2)}') # call anonymous functions by `dot` operation
IO.puts('double.(4) = #{double.(4)}')
IO.puts('is_function add = #{is_function add}')
IO.puts('is_function add, 2 = #{is_function add, 2}')
(fn -> x = 10 end).() # the last expression is the return value

# >>>> Lists

[1, 2, 3]
[1, true, 3] # in the list can be any type values
length [1, 2, 3] # 3 # linear time
[1, 2, 3] ++ [4, 5] # [1, 2, 3, 4, 5]
[1, 2, 3] -- [2, 3] # [1]
hd [1, 2, 3] # 1 - head of the list
tl [1, 2, 3] # [2, 3] - tail of the list

# >>>> Tuples

tuple = {:ok, "hello"}
elem(tuple, 1) # "hello"
tuple_size(tuple) # 2 # constant time
put_elem(tuple, 1, "world") # {:ok, "world"}

# >>>> Booleans

# As a rule of thumb, use and, or and not when you are expecting booleans.
# If any of the arguments are non-boolean, use &&, || and !.

IO.puts("true and true = #{true and true}")
IO.puts("false or true = #{false or true}")
IO.puts("not false = #{not false}")
IO.puts("123 && 17 = #{123 && 17}") # 17
IO.puts("nil || 17 = #{nil || 17}") # 17

# >>>> Pattern matching

x = 1
1 = x # pattern matching that x is 1
^x = 1 # pattern matching that x is 1

{a, b, c} = {:hello, "world", 42}
IO.puts("{a, b, c} = #{a} #{b} #{c}")

[a, b, c] = [:hello, "world", 42]
IO.puts("[a, b, c] = #{a} #{b} #{c}")

y = :ok
{:ok, result} = {:ok, 17} # pattern matching with
{^y, result} = {:ok, 17} # pattern matching with value of y (not assigning to y)
{"forward", x} = {"forward", {1, 2, 3}}

[head | tail] = [1, 2, 3]
IO.puts("head = #{head}")

[head | _] = [1, 2, 3] # _ - value that will be ignored

list = [1, 2, 3]
list = [0 | list]

# >>>> Control structures

case [1, 2, 3] do
  [4, 5, 6] -> "Don't match"
  [1, x, 3] -> "Matched #{x}"
  _ -> "Match any value"
end

x = 1
case 1 do
  10 -> nil
  5 -> nil
  ^x -> "Matched #{x}"
  _ -> nil
end

case [1, 2, 3] do
  [1, x, 3] when x >= 0 -> "Matched #{x}"
end

case 1 do
  x when hd(x) -> "Won't match" # it's special guard which suppres error
  x -> "Got #{x}"
end

larger_than_two = fn
  n when is_integer(n) and n > 2 -> true
  n when is_integer(n) -> false
end

x = "asd"
case x do
  x when is_integer(x) -> "It's an integer"
  x when is_float(x) -> "It's a float"
  x when is_bitstring(x) -> "It's a bitstring"
  _ -> :unexpected_data
end

cond do
  2 + 2 == 5 -> "This will not be true"
  2 * 2 == 4 -> "This is true"
  true -> "This this always true"
end

cond do
  hd([1, 2, 3]) -> "not true"
  true -> "true"
end

if true do
  "This works"
end

unless false do
  "This works because not true"
end

if false, do: :this, else: :that # keyword list syntax

# >>>> Keyword lists

# They properties are:
# 1. can have pairs with the same keys
# 2. keys must be atoms
# 3. keys order as specified by the developer
# Keyword list don't used in the pattern matching widely.

list = [{:a, 1}, {:b, 2}] # whe first tuple value is a atom, its a keyword list
IO.puts(list == [a: 1, b: 2])
list = [a: 0] ++ list ++ [c: 3]
list[:a] # fetched first value at the front

# >>>> Maps

# Maps very useful in the pattern matching mechanism
# We must use map.field syntax and pattern matching for more asserting style of programming
# http://blog.plataformatec.com.br/2014/09/writing-assertive-code-with-elixir/

map = %{:a => 1, 2 => :b}
map[:a] # 1
map[2] # :b
map[:c] # nil

%{:a => a} = %{2 => :b, :a => 1}q
a # 1

Map.get(%{}, :a) # nil
%{}[:a] # nil
Map.get(%{:a => 1}, :a) # 1
%{:a => 1}[:a] # 1
Map.put(%{}, :a, 1) # %{a: 1}
Map.to_list(%{:a => 1, :b => 2}) # [a: 1, b: 2] or [{:a, 1}, {:b, 2}]
%{%{:a => 1, :b => 2} | :b => 3} # update existing value in the map
%{%{:a => 1, :b => 2} | :c => 3} # KeyError because :c not found in the map
%{a: 1, b: 2} # if all keys are atoms we can use keyword syntax for convenience
%{a: 1, b: 2}.a # 1 (we can use special map syntax for accessing map atom keys)

users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]
users[:john].name # John
users = put_in(users[:john].age, 31) # modify value in the hierarchy variable
users = put_in(users, [:john, :age], 32) # alternative way for runtime update path
users = update_in(users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end)
IO.inspect(users)

# >>>> Recursion

defmodule Recursion do
  def print_multiple_times(msg, n) when n <= 1 do
    IO.puts(msg)
  end
  def print_multiple_times(msg, n) do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end
end
Recursion.print_multiple_times("hello", 3) # hello hello hello

defmodule Recursion2 do
  def sum_list([head | tail], total) do
    sum_list(tail, total + head)
  end
  def sum_list([], total) do
    total
  end
end
Recursion2.sum_list([1, 2, 3], 0) # 6

defmodule Recursion3 do
  def double_elems([head | tail]) do
    [head * 2 | double_elems(tail)]
  end
  def double_elems([]) do
    []
  end
end
Recursion3.double_elems([1, 2, 3]) # [2, 4, 6]

# >> Enumerables

Enum.reduce([1, 2, 3], 0, fn (x, acc) -> x + acc end) # 6
Enum.map([1, 2, 3], fn x -> x * x end) # [1, 4, 9]
Enum.map(%{:a => 1, :b => 2}, fn {key, value} -> value * 2 end) # [2, 4]
Enum.map(1..3, fn x -> x * 2 end) # [2, 4, 6]
Enum.reduce(1..3, 0, &+/2) # 6
Enum.filter(1..9, fn x -> rem(x, 2) == 0 end) # [2, 4, 6, 8]
1..1_000 |> Enum.map(fn x -> x * 2 end) |> Enum.filter(fn x -> rem(x, 2) == 0 end) |> Enum.sum # 1001000
Enum.take(Stream.cycle(1..3), 10) # [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]

# >>>> Processes

pid = spawn fn -> 1 + 2 end # #PID<0.128.0>
Process.alive?(pid) # true
Process.alive?(self()) # pid of current process

send self(), {:hello, "world"}
receive do
  {:hello, msg} -> "Received `#{msg}`"
  {:world, msg} -> "Won't match"
end

receive do
  {:world, msg} -> msg
after
  2_000 -> "Nothing received after 2s"
end

parent = self()
spawn fn -> send(parent, {:hello, self()}) end
receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end

# spawn fn -> raise "oops" end # child raises an exception
# spawn_link fn -> raise "oops" end # abort parent when child raises an exception

{:ok, pid} = Agent.start_link(fn -> %{} end)
Process.register(pid, :kv)
:ok = Agent.update(:kv, fn map -> Map.put(map, :hello, :world) end)
:world = Agent.get(:kv, fn map -> Map.get(map, :hello) end)

# >>>> Require

# we need to require module to invoke macros (or call an `import` clause will do the same effect)
require Integer
Integer.is_odd(3) # true
Integer.is_even(2) # false

# we can import the most important functions for us so it can be visible in the current context

import List, only: [duplicate: 2] # import duplicate
import List, except: [delete: 2] # import everything except delete
import List, only: :macros # import only macros from the module
import List, only: :functions # import only functions from the module
duplicate :ok, 3 # [:ok, :ok, :ok]

is_atom(String) # true
to_string(String) # "Elixir.String"
:"Elixir.String" == String # true

# >>>> Protocol

defprotocol Size do
  @doc "Calculates size of a data structure"
  def size(data)
end
defimpl Size, for: BitString do
  def size(string), do: byte_size(string) # O(1)
end
defimpl Size, for: Map do
  def size(map), do: map_size(map) # O(1)
end
defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple) # O(1)
end
defimpl Size, for: List do
  def size(list), do: length(list) # O(n)
end
defmodule User do
  defstruct [:name, :age]
end
defimpl Size, for: User do
  def size(_), do: 2
end
Size.size("asdads") # 6
Size.size(%{a: 1, b: 2}) # 2
Size.size({1, 2, 3, 4}) # 4
Size.size([1, 2, 3]) # 3
#Size.size(%User{})

# >>>> Comprehensions

for n <- [1, 2, 3, 4], do: n * n # [1, 4, 9, 16]
for {:good, n} <- [good: 1, good: 2, bad: 3, good: 4], do: n * n # [1, 4, 16]

require Integer
for n <- 0..9, Integer.is_even(n), do: n # [0, 2, 4, 6, 8]

for dir <- ["/home/idfumg", "/home/idfumg/work"],
  file <- File.ls!(dir),
  path = Path.join(dir, file),
  File.regular?(path) do
    File.stat!(path).size
end

for file <- File.ls!("/home/idfumg/work"),
  path = Path.join("/home/idfumg/work", file),
  File.dir?(path) do
    IO.puts(path)
end

pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b} # [{213, 45, 132}, {64, 76, 32}, {76, 0, 0}, {234, 32, 15}]

for <<c <- " Hello world! ">>, c != ?\s, into: "", do: <<c>> # "Helloworld!"

for {key, value} <- %{a: 1, b: 2}, into: %{}, do: {key, value * value} # %{a: 1, b: 4}

# >>>> Sigils

regex = ~r/foo|bar/
"foo" =~ regex # true
"bat" =~ regex # false
"HELLO" =~ ~r/hello/ # false
"HELLO" =~ ~r/hello/i # true
~s(this is a string with "double" quotes, not 'single' ones) # generate a string with the sigils
~c(this is a char list containing 'single quotes') # generate a char list with the sigils
~w(this a string containing couple of words) # generate list of words
~w(foo bar bat) # gen word list
~w(foo bar bat)a # gen atom list
~w(foo bar bat йцу)c # gen char list
~w(foo bar bat йцу)s # gen string list
~s(string with escape codes \x26 #{"inter" <> "polation"}) # "string with escape codes & interpolation"
~S(string with escape codes \x26 #{"inter" <> "polation"}) # "string with escape codes \\x26 \#{\"inter\" <> \"polation\"}"
~S"""
multi
line
string
"""

# >>>> Exceptions

try do
  raise "oops"
rescue
  e in RuntimeError -> e
end

try do
  raise "oops"
rescue
  RuntimeError -> "Error!"
end

case File.read "hello" do
  {:ok, body} -> IO.puts "Success: #{body}"
  {:error, reason} -> IO.puts "Error: #{reason}"
end

{:ok, file} = File.open "sample", [:utf8, :write]
try do
  raise "oops, unexpected"
  File.write(file, "hello")
after
  IO.puts "after section called"
  File.close(file)
  nil
end

try do
  1 / 0
rescue
  ArithmeticError -> :infinity
else
  y when y < 1 and y > -1 ->
    :small
  _ ->
    :large
end
