states = {
    'A':{0:(1,1,'B'),  1:(0,-1,'C')},
    'B':{0:(1,-1,'A'), 1:(1,1,'D')},
    'C':{0:(0,-1,'B'), 1:(0,-1,'E')},
    'D':{0:(1,1,'A'),  1:(0,1,'B')},
    'E':{0:(1,-1,'F'), 1:(1,-1,'C')},
    'F':{0:(1,1,'D'),  1:(1,-1,'A')}
}

def puzzle(sm, steps):
    state, d, pos = 'A', {}, 0
    for i in range(12481997):
        val = d.get(pos, 0)
        theState = states[state][val]
        d[pos], pos, state = theState[0], pos+theState[1], theState[2]
    return list(d.values()).count(1)
print('Day 25 solution:', puzzle(states, 12481997))
