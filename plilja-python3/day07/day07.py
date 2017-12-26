import re
import sys
from collections import namedtuple, Counter


Program = namedtuple('Program', 'name children weight')


def read_input():
    programs = []
    for line in sys.stdin.readlines():
        program, weight, rest = re.match(r'(.+) \((\d+)\)(.*)', line).groups()
        if '->' in rest:
            children = rest[4:].strip().split(', ')
        else:
            children = []
        programs += [Program(program, children, int(weight))]
    return programs


def step1(programs):
    children = set()
    for program in programs:
        children |= set(program.children)
    for program in programs:
        if program.name not in children:
            return program
    return None


def step2(programs, root):
    weight_cache = {}
    namelookup = dict([(p.name, p) for p in programs])


    def weight(program):
        if program.name in weight_cache:
            return weight_cache[program.name]
        else:
            w = sum([weight(namelookup[c]) for c in program.children])
            w += program.weight
            weight_cache[program.name] = w
            return w


    def is_balanced(program):
        for c in program.children:
            if not is_balanced(namelookup[c]):
                return False
        s = set([weight(namelookup[c]) for c in program.children])
        return len(s) <= 1


    def go(program):
        for c in program.children:
            if not is_balanced(namelookup[c]):
                return go(namelookup[c])
        counter = Counter([weight(namelookup[c]) for c in program.children])
        target = counter.most_common()[0][0]
        actual = counter.most_common()[1][0]
        for c in program.children:
            if weight(namelookup[c]) == actual:
                return namelookup[c].weight + target - actual
        return None

        
    return go(root)


programs = read_input()
root = step1(programs)
print(root.name)
print(step2(programs, root))
