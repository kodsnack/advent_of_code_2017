import sys

#Split input by row and space
input = sys.stdin.read()
input = [r.split(' ') for r in input.split('\n') if r]

#Part 1
#If there are the same number of unique words as there are words, the passphrase is valid
print "Part 1:", sum([1 for r in input if len(r)==len(list(set(r)))])

#Part 2
#Sort all words alphabetically to handle all permutations of letters, then solve as part 1
input = [[''.join(sorted(list(w))) for w in r] for r in input]
print "Part 2:", sum([1 for r in input if len(r)==len(list(set(r)))])
