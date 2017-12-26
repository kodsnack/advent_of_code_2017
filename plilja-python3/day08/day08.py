import sys
from collections import defaultdict


def step1(inp):
    return run_instructions(inp)[0]


def step2(inp):
    return run_instructions(inp)[1]


def run_instructions(instructions):
    registers = defaultdict(int)
    largest = -float('inf')
    for row in instructions:
        [reg1, op, val, _if, reg2, comp, comp_val] = row.split()
        reg2_val = registers[reg2]
        if comp == '>':
            b = reg2_val > int(comp_val)
        elif comp == '<':
            b = reg2_val < int(comp_val)
        elif comp == '>=':
            b = reg2_val >= int(comp_val)
        elif comp == '<=':
            b = reg2_val <= int(comp_val)
        elif comp == '==':
            b = reg2_val == int(comp_val)
        elif comp == '!=':
            b = reg2_val != int(comp_val)
        else:
            raise ValueError('Unknown comparison ' + comp)

        if b:
            if op == 'inc':
                registers[reg1] += int(val)
            elif op == 'dec':
                registers[reg1] -= int(val)
            else:
                raise ValueError('Unknown operation ' + op)
            largest = max(largest, registers[reg1])
    return (max(registers.values()), largest)


inp = sys.stdin.readlines()
print(step1(inp))
print(step2(inp))
