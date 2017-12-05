from aocbase import readInput

inp = readInput()
ex = """0
3
0
1
-3"""

def puzzle1(s):
    insts = [int(x) for x in s.splitlines()]
    pc = 0
    steps = 0
    while 0 <= pc < len(insts):
        inst = insts[pc]
        insts[pc] = inst + 1
        pc = inst + pc
        steps = steps + 1
    return steps

def puzzle2(s):
    insts = [int(x) for x in s.splitlines()]
    pc = 0
    steps = 0
    while 0 <= pc < len(insts):
        inst = insts[pc]
        npc = inst + pc
        if inst >= 3:
            insts[pc] = inst - 1
        else:
            insts[pc] = inst + 1
        pc = npc
        steps = steps + 1
    return steps

print("Puzzle 1, example:  ", puzzle1(ex))
print("Puzzle 1, solution: ", puzzle1(inp))

print("Puzzle 2, example:  ", puzzle2(ex))
print("Puzzle 2, solution: ", puzzle2(inp))

