import sys

input = sys.stdin.readline()

#Part 1
#List all digits
input = [int(n) for n in input if n.isdigit()]
#Pair each digit with the one after it
zipped = zip(input, input[1:]+[input[0]])
#Compare and sum
print "Part 1:", sum([p[0] for p in zipped if p[0]==p[1]])

#Part 2
#Pair each digit with the one half way around
zipped = zip(input, input[len(input)/2:]+input[:len(input)/2])
#Compare and sum
print "Part 2:", sum([p[0] for p in zipped if p[0]==p[1]])
