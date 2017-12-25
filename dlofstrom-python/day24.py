import sys

input = sys.stdin.read()
input = [tuple([int(c) for c in l.split('/')]) for l in input.split('\n') if l]

queue = [([],set(input))]
bridges = []
while queue:
    built, rest = queue.pop(0)
    #If rest is empty, the bridge is done
    if not rest:
        bridges.append(rest)
        continue

    #Calculate which port to look for (0 at start)
    port = 0
    #If bridge has two or more pieces, eliminate already connected
    if len(built) >= 2:
        #If piece has two of same type
        s = set(built[-1])
        if len(s) == 1:
            port = s.pop()
        else:
            port = (set(built[-1]) - set(built[-2])).pop()
    #If bridge is only one piece, eliminate 0
    elif len(built) == 1:
        s = set(built[-1])
        if len(s) == 1:
            port = s.pop()
        else:
            port = (set(built[-1]) - set([0])).pop()
    
    #Try to find a port in remaining components
    found = False
    for r in rest:
        if port in r:
            queue.append((built+[r], set(rest) - set([r])))
            found = True
    #If no port is found, this bridge is completed
    if not found:
        bridges.append(built)


#Calculate strength and length for all bridges
maxlen = [(sum([e for t in b for e in t]),len(b)) for b in bridges]

#Strongest bridge
print "Part 1:", max(maxlen, key=lambda x: x[0])[0]

#Length of longest bridge
l = max(maxlen, key=lambda x: x[1])
#Length out of longest
print "Part 2:", max([m for m in maxlen if m[1]==l[1]], key=lambda x: x[0])[0]
         
