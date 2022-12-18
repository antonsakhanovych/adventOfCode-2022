type
  Alphabet = enum
    a = 1, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z,
    A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
  Rucksack = (string, string)
  BunchOfRucksacks = seq[Rucksack]

proc fileParser(fileName: string): BunchOfRucksacks = 
  for line in lines(fileName):
    let 
      firstCompartment: string = line.substr(0, (line.len div 2) - 1)
      secondCompartment: string = line.substr(line.len div 2, high(line))
    result.add((firstCompartment, secondCompartment))

proc parseAlphabet(c: char): Alphabet =
  for letter in Alphabet:
    if repr(letter)[0] == c:
      return letter

proc checkMisplaced(rucksack: Rucksack): Alphabet =
  for letter1 in rucksack[0]:
    for letter2 in rucksack[1]:
      if letter1 == letter2:
        return parseAlphabet(letter1)

proc cycleThroughAll(bunch: BunchOfRucksacks): int =
  for rucksack in bunch:
    result += ord(checkMisplaced(rucksack))
  return result
  

proc main() =
  let 
    allRucksacks: BunchOfRucksacks = fileParser("input.txt")
    priorityPoints: int = cycleThroughAll(allRucksacks)
  echo priorityPoints




if isMainModule:
  main()