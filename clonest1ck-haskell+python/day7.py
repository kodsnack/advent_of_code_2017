def checkWeights(fun):
    if(above.has_key(fun)):
        w = [checkWeights(x) for x in above[fun]]

        if(max(w) == min(w)):
            return weights[fun] + sum(w)
        else:
            print "Task 2: " + " " + str(weights[above[fun][(w.index(max(w)))]] - (max(w) - min(w)))
            exit()
    else:
        return weights[fun]


f = open("in7.txt", 'r')

weights = {}
funcs = []
above = {}
under = {}
top = ""

for line in f.readlines():
    line = line.split("\n")[0].split(" -> ")
    func = line[0].split(" (")
    funcs.append(func[0])
    weights[func[0]] = int(func[1].split(")")[0])

    if (len(line) > 1):
        stalling = line[1].split(", ")
        above[func[0]] = stalling
        for stall in stalling:
            under[stall] = func[0]

for func in funcs:
    if above.has_key(func) and not under.has_key(func):
        print "Task 1: " + func
        top = func
        checkWeights(func)
