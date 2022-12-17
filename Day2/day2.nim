import strutils

type
    Pick = enum None Rock Paper Scissors
    Fight = tuple[elf: char, me: char]
    Strategy = seq[Fight]


proc fileParser(fileName: string): Strategy = 
    for line in lines(fileName):
        result.add((line[0], line[2]))

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

proc match(fight: Fight): int = 
    let 
        mePick: Pick = getPick(fight.me)
        elfPick: Pick = getPick(fight.elf)
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
    

proc main() = 
    let 
        matches: Strategy = fileParser("input.txt")
        score: int = getAllResults(matches)
    echo "Result is: ", score


if isMainModule:
    main()
