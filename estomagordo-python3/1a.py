def solver(numstring):
    l = len(numstring)
    return sum(int(numstring[x]) if numstring[x] == numstring[(x + 1) % l] else 0 for x in range(l))

with open('input_1.txt', 'r') as f:    
    numstring = f.readline().strip()
    print(solver(numstring))