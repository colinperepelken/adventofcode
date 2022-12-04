list_contains = &(Enum.count(Enum.at(&1, 1) -- Enum.at(&1, 0)) == 0 or Enum.count(Enum.at(&1, 0) -- Enum.at(&1, 1)) == 0)
build_range = &(Enum.to_list(Enum.at(&1, 0)..Enum.at(&1, 1)))

{:ok, body} = File.read("input.txt")
body
|> String.split("\n", trim: true)
|> Enum.map(
  fn line -> String.split(line, ",")
  |> Enum.map(
    fn side -> String.split(side, "-")
    |> Enum.map(fn num -> elem(Integer.parse(num), 0) end)
    |> build_range.()
  end)
  |> list_contains.()
end)
|> Enum.count(&(&1))
|> IO.puts
