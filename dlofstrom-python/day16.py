import sys

input = sys.stdin.read()
input = [c for c in input.strip().split(',') if c]

#Part 1
def dance(d):
    #Make a copy of current order
    p = list(d)
    #Go through input and perform spins, exchanges and partners
    for l in input:
        if l[0] == 's':
            #Move sequence to front
            i = int(l[1:])
            p = p[-i:] + p[:-i]
        elif l[0] == 'x':
            #Swap at positions 
            a,b = [int(x) for x in l[1:].split('/')]
            p[a],p[b] = p[b],p[a]
        elif l[0] == 'p':
            #Swap characters
            a,b = [p.index(x) for x in l[1:].split('/')]
            p[a],p[b] = p[b],p[a]
    return ''.join(p)

#Dance once
print "Part 1:", dance("abcdefghijklmnop")

#Part 2
orders = []
order = "abcdefghijklmnop"
#Orders are repeated after a while
while order not in orders:
    orders.append(order)
    order = dance(order)

#Check for billionth iteration
print "Part 2:", orders[1000000000 % len(orders)]



