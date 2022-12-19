type
    Pick = enum None Rock Paper Scissors
    Fight = tuple[elf: Pick, me: Pick]
    Strategy = seq[Fight]

proc getPick(pick: char): Pick = 
    case pick:
        of 'A', 'X':
            return Rock
        of 'B', 'Y':
            return Paper
        of 'C', 'Z':
            return Scissors
        else:
            return None

proc getMyPick(elfPick: Pick, pick: char): Pick =
    case elfPick:
        of Rock:
            case pick:
                of 'X': return Scissors
                of 'Y': return elfPick
                of 'Z': return Paper
                else: return None
        of Paper:
            case pick:
                of 'X': return Rock
                of 'Y': return elfPick
                of 'Z': return Scissors
                else: return None
        of Scissors:
            case pick:
                of 'X': return Paper
                of 'Y': return elfPick
                of 'Z': return Rock
                else: return None
        else: return None

proc fileParser(fileName: string): Strategy = 
    for line in lines(fileName):
        result.add((getPick(line[0]), getPick(line[2])))

proc fileParser2(fileName: string): Strategy = 
    for line in lines(fileName):
        let elfPick: Pick = getPick(line[0])
        result.add(((elfPick), getMyPick(elfPick ,line[2])))

proc match(fight: Fight): int = 
    let 
        mePick: Pick = fight.me
        elfPick: Pick = fight.elf
    case mePick:
        of Rock:
            result += 1
            case elfPick:
                of Rock: result += 3
                of Paper: result += 0
                of Scissors: result += 6    
                else: return 0
        of Paper:
            result += 2
            case elfPick:
                of Rock: result += 6
                of Paper: result += 3
                of Scissors: result += 0    
                else: return 0
        of Scissors:
            result += 3
            case elfPick:
                of Rock: result += 0
                of Paper: result += 6
                of Scissors: result += 3    
                else: return 0
        else: return 0

proc getAllResults(strat: Strategy): int = 
    for fight in strat:
        result = result + match(fight)


proc part1() = 
    let 
        matches: Strategy = fileParser("input.txt")
        score: int = getAllResults(matches)
    echo "Answer for part1 is: ", score

proc part2() =
    let 
        matches: Strategy = fileParser2("input.txt")
        score: int = getAllResults(matches)
    echo "Answer for part2 is: ", score




if isMainModule:
    part1()
    part2()
