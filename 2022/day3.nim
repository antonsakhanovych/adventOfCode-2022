type
  Alphabet = enum
    a = 1, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z,
    A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
  Rucksack = (string, string)
  DividedRucksacks = seq[Rucksack]
  BunchOfRucksacks = seq[string]
  GroupOfElves = array[3, string]
  BunchOfGroups = seq[GroupOfElves]

proc fileParser(fileName: string): BunchOfRucksacks =
  for line in lines(fileName):
    result.add(line)

proc divideRucksacks(rucksacks: BunchOfRucksacks): DividedRucksacks = 
  for rucksack in rucksacks:
    let
      firstCompartment: string = rucksack.substr(0, (rucksack.len div 2) - 1)
      secondCompartment: string = rucksack.substr(rucksack.len div 2, high(rucksack))
    result.add((firstCompartment, secondCompartment))

proc getBunchOfGroups(elves: BunchOfRucksacks) : BunchOfGroups =
  var 
    count = 0
    group: GroupOfElves
    bunch: BunchOfGroups
  for elf in elves:
    group[count] = elf
    count += 1
    if count == 3:
      bunch.add(group)
      count = 0
  return bunch
    
proc parseAlphabet(c: char): Alphabet =
  for letter in Alphabet:
    if repr(letter)[0] == c:
      return letter

proc checkMisplaced(rucksack: Rucksack): Alphabet =
  for letter1 in rucksack[0]:
    for letter2 in rucksack[1]:
      if letter1 == letter2:
        return parseAlphabet(letter1)

proc checkMisplaced(group: GroupOfElves): Alphabet =
  let 
    elf1 = group[0]
    elf2 = group[1]
    elf3 = group[2]
  for letter1 in elf1:
    for letter2 in elf2:
      for letter3 in elf3:
        if letter1 == letter2 and letter2 == letter3:
          return parseAlphabet(letter3)


proc evalPriority(alph: Alphabet): int =
  return ord(alph)

proc cycleThroughAll(bunch: DividedRucksacks): int =
  for rucksack in bunch:
    let 
      letter = checkMisplaced(rucksack)
    result += evalPriority(letter)

proc cycleThroughAll(bunch: BunchOfGroups): int =
  for group in bunch:
    let 
      letter = checkMisplaced(group)
    result += evalPriority(letter)

proc part1() =
  let 
    allRucksacks: BunchOfRucksacks = fileParser("input.txt")
    divideRucksacks: DividedRucksacks = divideRucksacks(allRucksacks)
    priorityPoints: int = cycleThroughAll(divideRucksacks)
  echo "Answer for part 1 is: ", priorityPoints

proc part2() =
  let 
    allRucksacks: BunchOfRucksacks = fileParser("input.txt")
    bunch: BunchOfGroups = getBunchOfGroups(allRucksacks)
    priority: int = cycleThroughAll(bunch)
  echo "Rucksacks: ", bunch.len
  echo "Answer for part 2 is: ", priority



if isMainModule:
  part1()
  part2()