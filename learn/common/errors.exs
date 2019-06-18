# Raise a runtime error
raise "Runtime error"

# Raise an argument error
raise ArgumentError, message: "the argument value is invalid"

# Catch the raised errors and performs some actions regardless of error with `after`
{:ok, file} = File.open("/etc/resolv.conf")

try do
  IO.puts "Do some work"
rescue
  e in RuntimeError ->
    IO.puts "An error occured: " <> e.message
  _ in KeyError ->
    IO.puts "Missing key value"
  _ in File.Error ->
    IO.puts "Unable to read the file"
after
  File.close(file)
end

# Exit execution with a specific value and catch it later
try do
  for x <- 1..000 do
    if x == 5, do: throw(x)
  end
catch
  x ->
    IO.puts "Caught: #{x}"
end
