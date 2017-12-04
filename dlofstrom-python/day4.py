import sys
from itertools import permutations

input = sys.stdin.read()
input = [r.split(' ') for r in input.split('\n') if r]

#Part 1
print "Part 1:", sum([1 for r in input if len(r)==len(list(set(r)))])


#Part 2
#Assume all rows valid
s = len(input)
for row in input:
    #Loop until row is empty
    while row:
        #Pop item in list and compare to all permutations to all other words
        word = row.pop()
        if len([1 for w in [''.join(p) for p in list(permutations(word))] if w in row]) != 0:
            #If one word is matched in any comparison the row is not valid
            s -= 1
            break
print "Part 2:", s

