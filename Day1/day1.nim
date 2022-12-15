import strutils

var 
    biggest: int = 0
    sum: int = 0

for line in lines("input.txt"):
    if line == "":
        if sum>biggest:
            biggest = sum
            sum = 0
        else:
            sum = 0
        continue
    sum = sum + parseInt(line)
    
echo biggest