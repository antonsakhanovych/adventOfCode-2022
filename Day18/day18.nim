import strutils

type
    Cube = array[3, int]
    ManyCubes = seq[Cube]
    SurfAreaOne = int
    SurfAreaAll = seq[SurfAreaOne]

proc fileParser(fileName: string): seq[string] =
    result = readFile(fileName).strip().split()

proc toCubes(content: seq[string]): ManyCubes =
    for strCube in content:
        var 
            coordinates: seq[string] = strCube.split(",")
            intCube: Cube = [0, 0, 0]
        for ind, coord in coordinates:
            intCube[ind] = parseInt(coord)
        result.add(intCube)
        
proc findTouchingCubes(ind: int, cube: Cube, collection: ManyCubes): SurfAreaOne =
    let 
        x = cube[0]
        y = cube[1]
        z = cube[2]
        xes = [x+1, x-1]
        yes = [y+1, y-1]
        zes = [z+1, z-1]
    var area: SurfAreaOne = 6
    for i, otherCube in collection:
        if i == ind:
            continue
        let 
            ox = otherCube[0]
            oy = otherCube[1]
            oz = otherCube[2]

        if ox == x:
            if oy == y:
                for zet in zes:
                    if oz == zet:
                        area -= 1
        if oz == z:
            if ox == x:
                for yet in yes:
                    if oy == yet:
                        area -= 1
        if oy == y:
            if oz == z:
                for xet in xes:
                    if ox == xet:
                        area -= 1                         
    return area

proc findAllTouching(collection: ManyCubes): SurfAreaAll =
    for ind, cube in collection:
        result.add(findTouchingCubes(ind, cube, collection))

proc sumAll(areas: SurfAreaAll): int =
    for area in areas:
        result += area

proc part1() =
    let 
        content = fileParser("input.txt")
        collection = toCubes(content)
        allArea: SurfAreaAll = findAllTouching(collection)
        sumArea: int = sumAll(allArea)
    echo "Answer for part 1 is: ", sumArea

if isMainModule:
    part1()