from aocbase import readInput

inp = readInput()

def unique(l):
    return len(l)==len(set(l))

def uniqueAna(l):
    l = list(map(lambda i:tuple(sorted(i)), l))
    return len(l)==len(set(l))

def checkPw1(s):
    return len(tuple(filter(lambda ws:unique(ws.split()), s.splitlines())))
    
def checkPw2(s):
    return len(tuple(filter(lambda ws:uniqueAna(ws.split()), s.splitlines())))

print(checkPw1(inp))
print(checkPw2(inp))