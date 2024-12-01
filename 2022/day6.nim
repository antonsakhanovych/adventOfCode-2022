import std/[os, strutils, sets]

proc calculate(input: string, markSize: int): int =
  var
    li = 0
    hi = markSize - 1
  while hi < len(input):
    let subrange = input[li..hi].toHashSet()
    if subrange.len == markSize: break
    inc(li)
    inc(hi)
  return hi + 1

proc main() =
  if paramCount() == 0:
    quit("Please specify the fileName!")
  let fileName = paramStr(1)
  let input = readFile(fileName)
  echo("Part1: ", calculate(input, 4))
  echo("Part1: ", calculate(input, 14))

if isMainModule:
  main()
