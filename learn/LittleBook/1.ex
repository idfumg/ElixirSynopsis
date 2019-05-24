defmodule MeterToLengthConverter do
  def convert(:feet, m) when is_number(m) and m >= 0, do: m * 3.28084
  def convert(:inch, m) when is_number(m) and m >= 0, do: m * 39.3701
  def convert(:yard, m) when is_number(m) and m >= 0, do: m * 1.09361
end

div(10, 3) # 3
rem(10, 3) # 1

"Strings are binaries" |> is_binary === true
"ohai" <> <<0>> === <<111, 104, 97, 105, 0>>
?o === 111
?h === 104
?a === 97
?i === 105
<<111, 104, 97, 105>> === "ohai"
'ohai' == "ohai" # false

elem({1, 2, 3}, 1) === 2
put_elem({1, 2, 3}, 0, 0) === {0, 2, 3}

programmers = Map.new # %{}
programmers = Map.put(programmers, :joe, "Erlang") # %{joe: "Erlang"}
programmers = Map.put(programmers, :matz, "Ruby") # %{joe: "Erlang", matz: "Ruby"}
programmers = Map.put(programmers, :rich, "Clojure") # %{joe: "Erlang", matz: "Ruby", rich: "Clojure"}
Map.fetch(programmers, :rich) # {:ok, "Clojure"}
Map.fetch(programmers, :rasmus) # :error
case Map.fetch(programmers, :rich) do
  {:ok, language} ->
    language
  :error ->
    "Wrong language"
end # "Clojure"

defmodule ID3Parser do
  def parse(filename) do
    case File.read(filename) do
      {:ok, mp3} ->
        mp3_byte_size = byte_size(mp3) - 128
        << _ :: binary-size(mp3_byte_size), id3_tag :: binary >> = mp3
        <<
        "TAG",
          title :: binary-size(30),
          artist :: binary-size(30),
          album :: binary-size(30),
          year :: binary-size(4),
          _rest :: binary
        >> = id3_tag
        IO.puts "#{artist} - #{title} (#{album}, #{year})"
      _ ->
        IO.puts "Couldn't open #{filename}"
    end
  end
end

defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten(head), do: [head]
end
MyList.flatten [1, [:two], ["three", []]] # [1, :two, "three"]

"/home/idfumg/Downloads"
|> Path.join("*.pdf")
|> Path.wildcard
|> Enum.filter(fn filename ->
  filename |> Path.basename |> String.contains?("Linux")
end)

:random.uniform(123)

# :inets.start
# :ssl.start
# {:ok, {status, headers, body}} = :httpc.request 'https://elixir-lang.org'

# :observer.start

:crypto.hash(:md5, "Tales from the Crypt") === <<79, 132, 235, 77, 3, 224, 121, 88, 98, 75, 61, 67, 62, 16, 233, 91>> # true
:crypto.hash(:sha, "Tales from the Crypt")
:crypto.hash(:sha256, "Tales from the Crypt")
:crypto.hash(:sha512, "Tales from the Crypt")
