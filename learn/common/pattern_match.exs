IO.inspect %{name: person_name} = person = %{name: "Fred", age: "95", favorite_color: "Taupe"}
IO.inspect person = %{name: person_name} = %{name: "Fred", age: "95", favorite_color: "Taupe"}
