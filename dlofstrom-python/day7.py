import sys
import re

input = sys.stdin.read()
#Split each row into: [name, weight, children....]
input = [re.split(r'\W+', l) for l in input.split('\n') if l]

#Create lookup for programs and their weights and children
weights = {l[0]:int(l[1]) for l in input}
children = {l[0]:l[2:] if l[2] else [] for l in input}

#Get the total node weight including all children weights
def get_sum(n):
    if children[n]:
        return weights[n] + sum([get_sum(c) for c in children[n]])
    else:
        return weights[n]

#Part 1
#Create a set with all child nodes
all_children = set([c for k in children for c in children[k]])
#The bottom node is the only node that isn't a child
bottom = [n for n in children if n not in all_children][0]
print "Part 1:", bottom

#Part 2
#Node to check balance, start at bottom
queue = [bottom]
#While the node children are unbalanced
node = ''
balance = []
wrong = 0
correct = 0
while queue:
    node = queue.pop(0)
    #Check the balance of children
    balance = [get_sum(c) for c in children[node]]
    #If the node is unbalanced
    if len(set(balance))>1:
        #print node, balance
        correct = max(set(balance), key=balance.count)
        wrong = min(set(balance), key=balance.count)
        queue.append(children[node][balance.index(wrong)])     
#The loop terminates when there are no more unbalanced subtrees
#Current node now contains the node that have to be correced
print "Part 2:", weights[node]+(correct - wrong)
