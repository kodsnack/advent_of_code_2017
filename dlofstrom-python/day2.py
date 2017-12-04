import sys
from itertools import permutations

input = sys.stdin.read()

#Part 1
input = [[int(d) for d in r.split('\t')] for r in input.split('\n') if r]
print "Part 1:", sum([max(r)-min(r) for r in input])

#Part 2
print "Part 2:", sum([p[1]/p[0] for r in input for p in list(permutations(r, 2)) if p[1]%p[0]==0])

