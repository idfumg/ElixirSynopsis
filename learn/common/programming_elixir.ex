list = [1, 2, 3]
[a, b, c] = list
a # 1
b # 2
c # 3

list = [1, 2, [3, 4, 5]]
[a, b, c] = list
a # 1
b # 2
c # [3, 4, 5]

list = [1, 2, 3]
[a, 2, c] = list
a # 1
c # 3

list = [1, 2, 3]
[a, 1, b] = list # %MatchError{term: [1, 2, 3]}

list = [1, 2, 3]
[a, b] = list # %MatchError{term: [1, 2, 3]}

list = [1, 2, 3]
[a | b] = list
a # 1
b # [2, 3]

list = [[1, 2, 3]]
a = [[1, 2, 3]]
a # [[1, 2, 3]]

list = [[1, 2, 3]]
[a] = list
a # [1, 2, 3]

list = [[1, 2, 3]]
[[a]] = list
a # %MatchError{term: [[1, 2, 3]]}

list = [[1, 2, 3]]
[[a, b, c]] = list
a # 1
b # 2
c # 3

[1, _, _] = [1, 2, 3] # [1, 2, 3]

a = 1
^a = 1 # 1 (use variable value in the match)

a = 1
^a = 2 # %MatchError{term: 2}

a = 1
[^a, 2, 3] = [1, 2, 3] # [1, 2, 3]

[a, b, a] = [1, 2, 1] # [1, 2, 1]
[a, b, a] = [1, 2, 3] # %MatchError{term: [1, 2, 3]}

list = [1, 2, 3]
list = [0 | list] # [0, 1, 2, 3]

{status, count, action} = {:ok, 42, "next"}
status # :ok
count # 42
action # "next"

[1, 2, 3] ++ [4, 5, 6] # [1, 2, 3, 4, 5, 6]
[1, 2, 3] -- [2, 3] # [1]
1 in [1, 2, 3] # true
1 in 0..2 # true

# It is a keyword list (internally will be converted into list of pairs
# [{:name, "Dave"}, {:city, "Dallas"}, {:likes, "Programming"}]
# The keyword list can contains repeated keys.
[name: "Dave", city: "Dallas", likes: "Programming"]
days = [monday: 1, thursday: 2]
Keyword.get(days, :monday) # 1 (useful for passing function parameters)
Float.to_string(1/3, [decimals: 3]) # "0.333"
Float.to_string(1/3, decimals: 3, compact: true) # "0.333" (can omit bracket squares)

# Map is a hash. It is can't contains repeated keys.
colors = %{
  :red => 0xff0000,
  :green => 0x00ff00,
  :blue => 0x0000ff,
}

# shortcut if all keys are atoms (the same technics that in the keyword list)
colors = %{
  red: 0xff0000,
  green: 0x00ff00,
  blue: 0x0000ff,
}
colors[:red] # 0xff0000
colors[:"red"] # 0xff0000
colors.red # 0xff0000
colors[:purple] # nil
colors.purple # %KeyError{key: :purple, term: %{blue: 255, green: 65280, red: 16711680}}

bin = <<1, 2>>
byte_size bin # 2

bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2)>>
byte_size bin # 1 byte (8 bits)

# for `and`, `or`, `not` the first argument must be true or false
# for `&&`, `||`, `!` the first argument can be of any type
a = true
b = false
a or b
a and b
not a
a && b
a || b
!a

div 5, 2 # 2 (divisor)
rem 5, 2 # 1 (remainder)

<<1>> <> <<2>> # <<1, 2>>

sum = fn (a, b) -> a + b end
sum.(1, 2) # 3

swap = fn {a, b} -> {b, a} end
swap.({2, 3}) # {3, 2}

handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end
handle_open.(File.open("/home/idfumg/.emacs")) # ok displays first line
handle_open.(File.open("/home/idfumg/.wrong_file")) # "Error: no such file or directory"

func1 = fn -> fn -> "Hello" end end
func1.() # returns a function object
func1.().() # "Hello"

func2 = fn name -> (fn -> "Hello, #{name}" end) end # closures
func2.("idfumg").() # "Hello, idfumg"

times_2 = fn n -> n * 2 end
apply = fn (func, value) -> func.(value) end
apply.(times_2, 6) # 12

list = [1, 2, 3]
Enum.map(list, fn (elem) -> elem * elem end) # [1, 4, 9]

add_one = &(&1 + 1) # converted to fn elem -> elem + 1 end
add_one.(1) # 2

divrem = &{div(&1, &2), rem(&1, &2)}
divrem.(5, 2) # {2, 1}

len = &length/1 # elixir alias
len.([1,2,3]) # 3

Enum.map([1, 2, 3], &(&1 * &1)) # [1, 4, 9]

defmodule Factorial do
  def factorial(0) do
    1
  end
  def factorial(n) when n > 0 do
    n * factorial(n - 1)
  end
end
Factorial.factorial(5) # 120

defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts("#{x} is a number")
  end
  def what_is(x) when is_list(x) do
    IO.puts("#{inspect(x)} is a list")
  end
  def what_is(x) when is_atom(x) do
    IO.puts("#{x} is an atom")
  end
end
Guard.what_is(1) # 1 is a number
Guard.what_is([1, 2, 3]) # 1 is a list
Guard.what_is(:a) # 1 is an atom

1..10
  |> Enum.map(&(&1 * &1))
  |> Enum.filter(&(&1 < 40)) # [1, 4, 9, 16, 25, 36]

# each module converts by Elixir parser into atom
is_atom IO # true
to_string IO # "Elixir.IO"
IO === :"Elixir.IO" # true

# recursive list definition
[2, 3] == [2 | [3 | []]] # true
[1, 2, 3] == [1 | [2 | [3 | []]]] # true
hd([1, 2, 3]) # 1
tl([1, 2, 3]) # [2, 3]

defmodule MyListLen do
  def len([]), do: 0
  def len([_ | tail]), do: 1 + len(tail)
end
MyListLen.len([1, 2, 3]) # 3

defmodule MyListSquare do
  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]
end
MyListSquare.square([1, 2, 3]) # [1, 4, 9]

defmodule MyMap do
  def map([], _), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]
end
MyMap.map([1, 2, 3], &(&1 * &1)) # [1, 4, 9]

defmodule MySum do
  defp sum([], total), do: total
  defp sum([head | tail], total), do: sum(tail, head + total)
  def sum(list), do: sum(list, 0)
end
MySum.sum([1, 2, 3]) # 6

defmodule MyReduce do
  def reduce([], value, _), do: value
  def reduce([head | tail], value, func), do: reduce(tail, func.(value, head), func)
end
MyReduce.reduce([1, 2, 3], 0, &(&1 + &2)) # 6

defmodule MySwapper do
  def swap([]), do: []
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
  def swap([a, b | tail]), do: [b, a | swap(tail)]
end
MySwapper.swap([1, 2, 3, 4, 5, 6]) # [2, 1, 4, 3, 6, 5]

d = %{first: 1, second: 2, third: 3}
d |> Dict.values |> Enum.sum # 6

kw_list = [name: "Dave", likes: "Programming", where: "Dalas"]
kw_hash = Enum.into kw_list, HashDict.new
kw_map = Enum.into kw_list, Map.new
kw_hash = Dict.drop(kw_hash, [:where, :likes])
kw_hash = Dict.put(kw_hash, :also_likes, "Ruby")
kw_map_and_hash = Dict.merge(kw_map, kw_hash)

kw_list = [name: "Dave", likes: "Programming", likes: "Elixir"]
kw_list[:likes] # "Programming"
Dict.get(kw_list, :likes) # "Programming"
Keyword.get(kw_list, :likes) # "Programming"
Keyword.get_values(kw_list, :likes) # ["Programming", "Elixir"]

person = %{name: "Dave", height: 1.88}
%{name: name_value} = person
name_value # "Dave"
%{name: _, height: _} = person
%{name: "Dave"} = person
%{weight: _} = person # %MatchError{term: %{height: 1.88, name: "Dave"}}

people = [
  %{ name: "Grumpy", height: 1.24 },
  %{ name: "Dave", height: 1.88 },
  %{ name: "Dopey", height: 1.32 },
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy", height: 1.28 },
]
for person = %{height: height} <- people, height > 1.5, do: IO.inspect person

m1 = %{a: 1, b: 2, c: 3}
m2 = %{m1 | b: "two", c: "three"}
m3 = %{m2 | a: "one"}

defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end
s1 = %Subscriber{}
s2 = %Subscriber{name: "Dave"}
s3 = %Subscriber{name: "Dave", paid: true}
%Subscriber{name: name_value} = s3
name_value # "Dave"
s4 = %Subscriber{s3 | name: "Marie"}

# update dictionary nested data
person = %{name: "Dave", company: %{name: "IBM"}}
person = put_in person.company.name, "Apple"
person = update_in person.company.name, &(&1 <> " Inc.")
person = get_in person, [:company, :name] # "Apple Inc."
person = get_in person, [:company, :wrong_atom] # %Protocol.UndefinedError{description: nil, protocol: Access, value: "Apple Inc."}

s1 = Enum.into 1..5, HashSet.new
Set.member? s1, 1 # true
s2 = Enum.into 6..9, HashSet.new
Set.union s1, s2 # #HashSet<[7, 2, 6, 3, 4, 1, 5, 9, 8]>
Set.difference s1, s2 # #HashSet<[2, 3, 4, 1, 5]>
Set.intersection s1, s2 # #HashSet<[]>

Enum.to_list 1..5 # [1, 2, 3, 4, 5]
Enum.concat [1, 2, 3], [4, 5, 6] # [1, 2, 3, 4, 5, 6]
Enum.map [1, 2, 3], &(&1 * 2) # [2, 4, 6]
Enum.map [1, 2, 3], &String.duplicate("*", &1) # ["*", "**", "***"]
Enum.at 1..5, 0 # 1
Enum.filter 1..5, &(&1 > 3) # [4, 5]
Enum.filter 1..9, &Integer.is_even/1
Enum.reject 1..9, &Integer.is_odd/1
Enum.sort [2, 1, 6, 4, 9] # [1, 2, 4, 6, 9]
Enum.sort [2, 1, 6, 4, 9], &(&1 > &2) # [9, 6, 4, 2, 1]
Enum.sort_by [2, 1, 6, 4, 9], &(-&1) # [9, 6, 4, 2, 1]
Enum.sort ["there", "was", "a", "crooked", "man"], &(String.length(&1) <= String.length(&2)) # ["a", "was", "man", "there", "crooked"]
Enum.max ["there", "was", "a", "crooked", "man"] # "was"
Enum.max_by ["there", "was", "a", "crooked", "man"], &String.length/1 # "crooked"
Enum.take 1..9, 3 # [1, 2, 3]
Enum.take_every 1..9, 2 # [1, 3, 5, 7, 9]
Enum.take_while 1..9, &(&1 < 4) # [1, 2, 3]
Enum.split 1..9, 3 # {[1, 2, 3], [4, 5, 6, 7, 8, 9]}
Enum.split_while 1..9, &(&1 < 5) # {[1, 2, 3, 4], [5, 6, 7, 8, 9]}
Enum.join 1..5 # "12345"
Enum.join 1..5, "," # "1,2,3,4,5"
Enum.all? 1..5, &(&1 < 6) # true
Enum.any? 1..5, &(&1 < 2) # true
Enum.member? 1..5, 3 # true
Enum.empty? [] # true
Enum.zip 1..3, [:a, :b, :c] # [{1, :a}, {2, :b}, {3, :c}]
Enum.zip [:a, :b, :c], 1..3 # [a: 1, b: 2, c: 3] (it's the same as before actualy)
Enum.with_index ["once", "upon", "a", "time"] # [{"once", 0}, {"upon", 1}, {"a", 2}, {"time", 3}]
Enum.reduce 1..3, &(&1 + &2) # 6

for x <- 1..5, do: x * x # [1, 4, 9, 16, 25]
for x <- 1..5, x < 4, do: x * x # [1, 4, 9]
for x <- 1..2, y <- 3..5, do: x * y # [3, 4, 5, 6, 8, 10]
for x <- 1..2, y <- 3..5, do: {x, y} # [{1, 3}, {1, 4}, {1, 5}, {2, 3}, {2, 4}, {2, 5}]
for {min, max} <- [{1, 4}, {2, 3}, {10, 15}], n <- min..max, do: n # [1, 2, 3, 4, 2, 3, 10, 11, 12, 13, 14, 15]
for <<ch <- "Hello">>, do: ch
for <<ch <- "Hello">>, do: <<ch>>
for << << b1::size(8) >> <- "123" >>, do: "0x#{b1}" # ["0x49", "0x50", "0x51"]
for x <- ~w{cat dog}, do: {x, String.upcase(x)} # [{"cat", "CAT"}, {"dog", "DOG"}]
for x <- ~w{cat dog}, into: %{}, do: {x, String.upcase(x)} # %{"cat" => "CAT", "dog" => "DOG"}
for x <- ~w{cat dog}, into: Map.new, do: {x, String.upcase(x)} # %{"cat" => "CAT", "dog" => "DOG"}


'wombat' # char list
"wombat" # string (sequence of bytes in UTF-8 encoding)
s = 'wombat' # 'wombat' (Elixir print that because it thinks that is can be represented as a string)
is_list 'wombat' # true
length 'wombat' # 6
Enum.reverse 'wombat' # 'tabmow'
List.to_tuple 'wombat' # {119, 111, 109, 98, 97, 116}
List.to_string 'wombat' # "wombat"
'wombat' ++ [0] # [119, 111, 109, 98, 97, 116, 0] (not all bytes printable so Elixir print this as a list)
'pole' ++ 'vault'
'pole' -- 'vault'
List.zip ['abc', '123'] # [{97, 49}, {98, 50}, {99, 51}]
[head | tail] = 'cat'; head # 99
[head | tail] = 'cat'; tail # 'at'
[head | tail] = 'cat'; [head | tail] # 'cat'

byte_size << 1, 2, 3>> # 3 byte
bit_size << 1, 2, 3 >> # 24 bit
byte_size << 1::size(2), 1::size(3) >> # 1 byte
bit_size << 1::size(2), 1::size(3) >> # 5 bit
<< 2.5 :: float >> # <<64, 4, 0, 0, 0, 0, 0, 0>>

<< sign::size(1), exp::size(11), mantissa::size(52) >> = << 3.14159::float >>
(1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exp-1023) # 3.14159

String.length "abc" # 3
String.length "абс" # 3
byte_size "абс" # 6
String.at "abc", 0 # "a"
String.at "abc", -1 # "c"
is_binary "abc" # true
is_bitstring "abc" # true
is_list "abc" # false
Enum.each 'абс', &(IO.write "#{&1} ") # 1072 1073 1089
Enum.each 'абс', &(IO.write/1) # 107210731089

if true, do: "true part", else: "else part" # "true part"
if false, do: "true part", else: "else part" # "else part"

if true do
  "true part"
else
  "else part"
end

unless false, do: "not something", else: "true something" # "not something"

unless false do
  "true part"
else
  "else part"
end

dave = %{name: "Dave", state: "TX", likes: "Programming"}
case dave do
  %{state: some_state} = person -> IO.puts "#{person.name} lives in #{some_state}"
  _ -> IO.puts "No matches"
end # Dave lives in TX

dave = %{name: "Dave", state: "TX", likes: "Programming", age: 21}
case dave do
  person = %{state: some_state, age: age} when is_number age ->
    IO.puts "#{person.name} #{person.age} lives in #{some_state}"
  _ ->
    IO.puts "No matches"
end # Dave lives in TX

raise "Giving up" # %RuntimeError{message: "Giving up"}
raise RuntimeError # %RuntimeError{message: "runtime error"}
raise RuntimeError, message: "override message" # %RuntimeError{message: "override message"}
{:ok, file} = File.open("config_file") # %MatchError{term: {:error, :enoent}}
file = File.open!("config_file") # %File.Error{action: "open", path: "config_file", reason: :enoent}

defmodule Factorial do
  def factorial (0), do: 1
  def factorial (n), do: n * factorial(n - 1)
end

defmodule SpawnBasic do
  def greet do
    IO.puts "Hello!"
  end
end
SpawnBasic.greet # Hello!
spawn(SpawnBasic.greet) # Hello!
spawn(fn () -> IO.puts "Hello!" end) # Hello!

defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, #{msg}"}
        greet
    end
  end
end
pid = spawn(Spawn1, :greet, [])
send pid, {self, "World!"}
receive do
  {:ok, message} ->
    IO.puts message
end
send pid, {self, "Kermit!"}
receive do
  {ok, message} ->
    IO.puts message
after 500 ->
    IO.puts "The greeter has gone away. Timeout!"
end

defmodule TailRecursive do
  def factorial(n), do: _fact(n, 1)
  defp _fact(0, acc), do: acc
  defp _fact(n, acc), do: _fact(n - 1, n * acc)
end
TailRecursive.factorial(5) # 120

defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end
  def create_processes(n) do
    last_pid = Enum.reduce 1..n, self, fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end
    send last_pid, 0
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end
end
IO.puts inspect :timer.tc(Chain, :create_processes, [400_000])

defmodule Link1 do
  import :timer, only: [sleep: 1]
  def sad_function do
    sleep 500
    exit(:boom)
  end
  def run do
    Process.flag(:trap_exit, true)
    spawn(Link1, :sad_function, [])
    receive do
      msg -> IO.puts "Message received: #{msg}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
Link1.run # "Nothing happened as far as I am concerned"

defmodule Link2 do
  import :timer, only: [sleep: 1]
  def sad_function do
    sleep 500
    exit(:boom)
  end
  def run do
    spawn_link(Link2, :sad_function, [])
    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
Link2.run # child process killed entire application

defmodule Link3 do
  import :timer, only: [sleep: 1]
  def sad_function do
    sleep 500
    exit(:boom)
  end
  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link3, :sad_function, [])
    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
Link3.run # handle situation when the child process was killed

defmodule Monitor1 do
  import :timer, only: [sleep: 1]
  def sad_function do
    sleep 500
    exit(:boom)
  end
  def run do
    spawn_monitor(Monitor1, :sad_function, [])
    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
Monitor1.run # watch if the child process was down

defmodule ParallelMap do
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> send me, {self, fun.(elem)} end
    end)
    |> Enum.map(fn (pid) ->
      receive do
        {^pid, result} -> result
      end
    end)
  end
end
ParallelMap.pmap(1..10, &(&1 * &1)) # [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

defmodule FibAgent do
  def start_link do
    cache = %{0 => 0, 1 => 1}
    Agent.start_link(fn -> cache end)
  end
  def fib(agent_pid, n) when n >= 0 do
    Agent.get_and_update(agent_pid, &do_fib(&1, n))
  end
  defp do_fib(cache, n) do
    if cached = cache[n] do
      {cached, cache}
    else
      {val, cache} = do_fib(cache, n - 1)
      result = val + cache[n - 2]
      {result, Dict.put(cache, n, result)}
    end
  end
end
{:ok, agent_pid} = FibAgent.start_link()
IO.puts FibAgent.fib(agent_pid, 500)

Node.self

person = {"Bob", 25} # tuple
age = elem(person, 1) # 25
put_elem(person, 1, 26) # {"Bob", 26}

numbers = [1, 2, 3]
List.replace_at(numbers, 1, 11) # [1, 11, 3]
Enum.at(numbers, 0) # 1
1 in numbers # true
List.insert_at(numbers, -1, 9) # [1, 2, 3, 9]

iolist = []
iolist = [iolist, "This"]
iolist = [iolist, " is"]
iolist = [iolist, " an"]
iolist = [iolist, " IO list."]
iolist # [[[[[], "This"], " is"], " an"], " IO list."]
IO.puts iolist # This is an IO list.

{date, time} = :calendar.local_time
{year, month, day} = date
{hour, minute, second} = time

date_time = {_, {hour, _, _}} = :calendar.local_time
hour # 13

"ping " <> url = "ping www.example.com"
url # "www.example.com"

defmodule Geometry do
  def area({:rectangle, a, b}) do
    a * b
  end
  def area({:square, a}) do
    a * a
  end
  def area({:circle, r}) do
    r * r * 3.14159
  end
  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end
end

test_num = fn
  x when is_number(x) and x < 0 -> :negative
  0 -> :zero
  x when is_number(x) and x > 0 -> :positive
end
test_num.(-1) # :negative

defmodule TestNum do
  def test(x) when x < 0, do: :negative
  def test(0), do: :zero
  def test(x) when x > 0, do: :positive
end
TestNum.test(-1) # :negative

defmodule LinesCounter do
  def count(path) do
    File.read(path)
    |> lines_num
  end
  defp lines_num({:ok, contents}) do
    contents
    |> String.split("\n")
    |> length
  end
  defp lines_num(error), do: error
end
LinesCounter.count("./programming_elixir.ex")

# how Elixir uses abstractions throught modules and their functions
days =
  HashDict.new
  |> HashDict.put(1, "Monday")
  |> HashDict.put(2, "Tuesday")
HashDict.get(days, 1) # "Monday"

defmodule DatabaseServer do
  def start do
    spawn(&loop/0)
  end
  defp loop do
    receive do
    end
    loop
  end
end
DatabaseServer.start
