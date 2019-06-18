# String is a sequence of bytes
IO.inspect <<104,101,108,108,111>>

# With not a valid byte iex wouldn't display it as String
IO.inspect <<104,101,108,108,111>> <> <<0>>

# Charlist is the Unicode symbol codes sequence (can be represented with a one symbol)
IO.inspect 'привет'

# String (binary) is a UTF-8 symbol codes sequence (can be represented as several symbols)
IO.inspect "привет"

# Show code of character
IO.inspect ?Z
