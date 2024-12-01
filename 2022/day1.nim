import strutils

proc fileParser(fileName: string): seq[int] =
    var 
        calories: seq[int] = @[]
        sum: int = 0

    for line in lines(filename):
        if line == "":
            calories.add(sum)
            sum = 0
        else:
            sum = sum + parseInt(line)
    return calories

proc getBiggest(calories: seq[int]): (int, int) = 
    var 
        biggest: int = 0
        ind: int = 0
    for i, cal in calories:
        if cal > biggest:
            biggest = cal
            ind = i
    return (ind, biggest)

proc part1() =
    let 
        calories: seq[int] = fileParser("input.txt")
        biggest: (int, int) = getBiggest(calories)
    echo "Answer for the first part: ", biggest[1]

proc sumCalories(calories: openArray[int]): int =
    for el in calories:
        result += el

proc part2() =
    var 
        calories: seq[int] = fileParser("input.txt")
        threeBiggest: array[3, int] = [0, 0, 0]
    for ind, _ in threeBiggest:
        let res = getBiggest(calories)
        threeBiggest[ind] = res[1]
        calories.del(res[0])
    echo "Answer for the second part: ", sumCalories(threeBiggest)
        

if isMainModule:
    part1()
    part2()
