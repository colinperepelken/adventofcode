letters = (?a..?z |> Enum.to_list) ++ (?A..?Z |> Enum.to_list) |> Enum.with_index

{:ok, body} = File.read("input.txt")
body
|> String.split("\n", trim: true)
|> Enum.map(&String.graphemes/1)
|> Enum.chunk_every(3)
|> Enum.map(fn group -> Enum.reduce(group, MapSet.new(Enum.at(group, 0)), fn responses, acc ->
  MapSet.intersection(MapSet.new(responses), acc)
end) |> MapSet.to_list |> Enum.at(0) end)
|> Enum.map(fn bagLetter -> Enum.find(letters, fn letter -> <<elem(letter, 0)>> == bagLetter end) |> elem(1) |> Kernel.+(1) end)
|> Enum.sum
|> IO.puts
