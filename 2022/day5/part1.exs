
# Read the file
{:ok, body} = File.read("input.txt")
parts = String.split(body, "\n\n", trim: true)

# Split input into stackInput and movesInput
stackInput = Enum.at(parts, 0) |> String.split("\n")
stackInput = Enum.drop(stackInput, -1) |> Enum.map(fn line -> String.graphemes(line) end)
movesInput = Enum.at(parts, 1) |> String.split("\n") |> Enum.drop(-1)

# Parse the stacks (should have just hardcoded this...)
filledStacks = Enum.map( (List.duplicate([], 9) |> Enum.with_index),
  fn {_stack, index} ->
    Enum.map(stackInput,
      fn line ->
          Enum.at(line, 1 + (index * 4))
      end )|> Enum.filter(
        fn item ->
          item !== " "
        end)
  end)

# Define a function to move stacks around
# Returns a new list of stacks
moveStacks = fn stacks, amount, source, destination ->
  sourceStack = Enum.at(stacks, source)
  destinationStack = Enum.at(stacks, destination)
  toMove = Enum.slice(sourceStack, 0, amount)

  newSource = sourceStack -- toMove
  newDestination =  Enum.reverse(toMove) ++ destinationStack

  stacks
    |> List.replace_at(source, newSource)
    |> List.replace_at(destination, newDestination)
end

# Parse the moves
moves = Enum.map(
  movesInput,
  fn move -> String.split(move, " ")
    |> (&([Enum.at(&1, 1), Enum.at(&1, 3), Enum.at(&1, 5)])).()
    |> Enum.map(fn num -> elem(Integer.parse(num), 0) end)
    end)

# Run through all of the moves and determine the result
result = Enum.reduce(moves, filledStacks, fn [amount, source, destination], accumulator ->
  moveStacks.(accumulator, amount, source - 1, destination - 1)
end)

IO.inspect(result)
