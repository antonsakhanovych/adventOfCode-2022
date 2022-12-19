import strutils

type
    Range = array[2, int]
    Pair = (Range, Range)
    BunchOfPairs = seq[Pair]

proc fileParser(fileName: string): seq[string] =
    # Returns a bunch of lines as strings
    result = readFile(fileName).strip().splitLines()

proc divideIntoPair(pair: string): Pair =
    let
        ranges: seq[string] = pair.split(",")
        firstElfRangeStr: seq[string] = ranges[0].split("-")
        secondElfRangeStr: seq[string] = ranges[1].split("-")
    var    
        firstElf: Range 
        secondElf: Range
    for ind, nStr in firstElfRangeStr:
        firstElf[ind] = parseInt(nStr)
    for ind, nStr in secondElfRangeStr:
        secondElf[ind] = parseInt(nStr)
    return (firstElf, secondElf)

proc divideEach(allPairs: seq[string]): BunchOfPairs =
    for pair in allPairs:
        let
            aPair: Pair = divideIntoPair(pair)
        result.add(aPair)
    
proc compare(pair: Pair): bool =
    let 
        firstElf = pair[0]
        secondElf = pair[1]
    if firstElf[0] <= secondElf[0] and firstElf[1] >= secondElf[1]:
        return true
    if secondElf[0] <= firstElf[0] and secondElf[1] >= firstElf[1]:
        return true
    return false

proc checkContainment(pair: Pair): bool =
    let 
        firstElf = pair[0]
        secondElf = pair[1]
    for i in 0..1:
        if firstElf[i] <= secondElf[1] and firstElf[i] >= secondElf[0]:
            return true
    for i in 0..1:
        if secondElf[i] <= firstElf[1] and secondElf[i] >= firstElf[0]:
            return true
    return false

proc compareAll(pairs: BunchOfPairs, action: proc(pair: Pair): bool): int =
    for pair in pairs:
        if action(pair):
            result += 1

proc part1() =
    let 
        content: seq[string] = fileParser("input.txt")
        pairs: BunchOfPairs = divideEach(content)
        count: int = compareAll(pairs, compare)
    echo "Answer for the part 1 is: ", count

proc part2() =
    let 
        content: seq[string] = fileParser("input.txt")
        pairs: BunchOfPairs = divideEach(content)
        count: int = compareAll(pairs, checkContainment)
    echo "Answer for the part 2 is: ", count


if isMainModule:
    part1()
    part2()