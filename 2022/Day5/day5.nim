import strutils

type
    Stack = seq[string]
    AllStacks = seq[Stack]
    Instruction = (int, int, int)
    ListOfInstructions = seq[Instruction]


# Gets lines from the file
proc fileParser(fileName: string): seq[string] = 
    result = readFile(fileName).splitLines()

# Reverses the sequence
proc reverse(sequence: Stack): Stack =
    let length: int = sequence.len
    for i in 0..<length:
        result.add(sequence[length - 1 - i])

# Checks if a strin is a number
proc isNumber(x: string): bool =
  try:
    discard parseInt(x)
    result = true
  except ValueError:
    result = false

# Divides stacks from instructions
proc divide(content: seq[string]): (seq[string], seq[string]) =
    var switch: bool = false
    for line in content:
        if line == "":
            switch = true
            continue
        if not switch:
            result[0].add(line)
        else:
            result[1].add(line)


# Deletes the unnessesary spaces
proc interpretStackLines(stackLines: seq[string]): seq[seq[string]] =
    var 
        count = 0
    for line in stackLines:
        let 
            line = line.split(" ")
        var stack: Stack
        for el in line:
            if el == "" and count != 3:
                count += 1
                continue
            stack.add(el)
            count = 0
        result.add(stack)

# Creates stacks from the correctly formed sequences
proc createStacks(stackLines: seq[seq[string]]): AllStacks =
    for i in 0..stackLines[0].len - 1:
        var stack: Stack
        for line in stackLines:
            if line[i] == "" or isNumber(line[i]):
                continue
            stack.add(line[i])
        stack = reverse(stack)
        result.add(stack)

proc getInstructions(instructions: seq[string]): ListOfInstructions =
    for instruction in instructions:
        let instr = instruction.split(" ")
        var 
            newInst: Instruction
        newInst[0] = parseInt(instr[1])
        newInst[1] = parseInt(instr[3])
        newInst[2] = parseInt(instr[5])
        result.add(newInst)

proc executeActions(stacks: var AllStacks, instructions: ListOfInstructions) =
    for instruction in instructions:
        let 
            numToMove = instruction[0]
            numFrom = instruction[1] - 1
            numTo = instruction[2] - 1
        for i in 1 .. numToMove:
            stacks[numTo].add(stacks[numFrom].pop())

proc show(stacks: AllStacks): string =
    for stack in stacks:
        result.add(stack[^1])

proc part1() =
    let 
        content = fileParser("input.txt")
        (stacks, instructions) = divide(content)
        interpretedStacks = interpretStackLines(stacks)
        allInstructions = getInstructions(instructions)
    var createdStacks = createStacks(interpretedStacks)
    executeActions(createdStacks, allInstructions)
    let result = show(createdStacks)
    echo "Answer for part 1 is: ", result
    

if isMainModule:
    part1()