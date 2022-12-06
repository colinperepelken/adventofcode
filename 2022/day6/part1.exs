{_, body} = File.read("input.txt")

chars = String.graphemes(body)
4..length(chars) |> Enum.reduce_while(-1, fn n, acc ->
  size = Enum.slice(chars, (n-3)..n) |> MapSet.new |> MapSet.size
  if size < 4, do: {:cont, acc}, else: {:halt, n + 1}
end) |> IO.inspect
