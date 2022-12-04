letters = (?a..?z |> Enum.to_list) ++ (?A..?Z |> Enum.to_list) |> Enum.with_index

{:ok, body} = File.read("input.txt")
body
|> String.split("\n", trim: true)
|> Enum.map(&String.graphemes/1)
|> Enum.map(fn bag -> Enum.split(bag, (div Enum.count(bag), 2)) end)
|> Enum.map(fn bag -> elem(bag, 0) -- (elem(bag, 0) -- elem(bag, 1)) |> Enum.uniq |> Enum.at(0) end)
|> Enum.map(fn bagLetter -> Enum.find(letters, fn letter -> <<elem(letter, 0)>> == bagLetter end) |> elem(1) |> Kernel.+(1) end)
|> Enum.sum
|> IO.puts
