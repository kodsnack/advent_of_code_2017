import sys
from collections import defaultdict

registry = defaultdict(int)
largest_value = 0

def dec(register, value):
    registry[register] -= value

def inc(register, value):
    global largest_value
    registry[register] += value
    largest_value = max(largest_value, registry[register])

for line in sys.stdin:
    parts = line.strip().split()
    register = parts[0]
    instruction, value = parts[1], int(parts[2])
    function_call = f'{instruction}("{register}",{value})'
    condition = f'registry["{parts[4]}"] {parts[5]} {parts[6]}'
    print(condition)
    if eval(condition):
        eval(function_call)

print(max(registry.values()))
print(largest_value)
