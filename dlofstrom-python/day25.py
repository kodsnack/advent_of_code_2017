import sys
import re

input = sys.stdin.read()
state = re.findall(r'(?<=Begin in state )\w+(?=.)',input)[0]
steps = int(re.findall(r'(?<=Perform a diagnostic checksum after )[0-9]+(?= steps.)',input)[0])
input = input.split('In ')

#Generate turing machine state lookup
lookup = {}
for l in input:
    s = re.findall(r'(?<=state )\w+(?=:)',l)
    if s:
        s = s[0]
        i = re.findall(r'(?<=current value is )\w+(?=:)',l)
        w = re.findall(r'(?<=Write the value )\w+(?=.)',l)
        m = re.findall(r'(?<=Move one slot to the )\w+(?=.)',l)
        c = re.findall(r'(?<=Continue with state )\w+(?=.)',l)
        m = [1 if x=='right' else -1 for x in m]
        lookup[(s,int(i[0]))] = (int(w[0]),m[0],c[0])
        lookup[(s,int(i[1]))] = (int(w[1]),m[1],c[1])

#Step through
strip = {}
slot = 0
for i in range(steps):
    #Read strip value
    value = 0
    if strip.has_key(slot):
        value = strip[slot]

    #State action
    w, m, c = lookup[(state, value)]
    strip[slot] = w
    slot += m
    state = c

#Count number of 1's on strip
print "Part 1:", strip.values().count(1)









