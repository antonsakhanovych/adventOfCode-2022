import std/[os, strutils, sequtils, algorithm]

type InputLists = tuple[left: seq[int], right: seq[int]]

proc get_input(): InputLists =
  if paramCount() != 1:
    stderr.writeLine("Please provide a file!")
    quit(1)
  var file = open(paramStr(1))
  var line: string
  while file.readLine(line):
    let splitted = splitWhitespace(line)
    result.left.add(parseInt(splitted[0]))
    result.right.add(parseInt(splitted[1]))
  result.left.sort()
  result.right.sort()

proc part1(input: InputLists): int =
  for (left, right) in zip(input.left, input.right):
    result += abs(right - left)

proc part2(input: InputLists): int =
  for left in input.left:
    result += left * input.right.count(left)

proc main() =
  let content = get_input()
  echo("Part 1: ", part1(content))
  echo("Part 2: ", part2(content))

when isMainModule:
  main()
