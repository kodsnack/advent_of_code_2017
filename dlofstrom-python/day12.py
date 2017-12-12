import sys

input = sys.stdin.read()
input = input.replace('<->',',')

#List of sets (all programs on a row can reach each other)
sets = [set([int(w) for w in line.split(', ')]) for line in input.split('\n') if line]

#Go through every set once
for i in range(len(sets)):
    #Get first set in list
    t = sets.pop(0)
    #Check if any other set has common nodes
    for s in sets:
        if s.intersection(t):
            s = s.update(t)
            break
    else:
        #If loop did not break re-add set to back of list
        sets.append(t)

print "Part 1:", len([s for s in sets if 0 in s][0])
print "Part 2:", len(sets)
