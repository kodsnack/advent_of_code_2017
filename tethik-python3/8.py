import sys
from collections import defaultdict

registry = defaultdict(int)
largest_value = 0

inc = sum
dec = lambda r,v: r-v

def dec(register, value):
    registry[register] -= value

def inc(register, value):
    global largest_value
    registry[register] += value
    largest_value = max(largest_value, registry[register])

for line in sys.stdin:
    parts = line.strip().split()
    registry.update(globals())

    eval(f'registry["{parts[4]}"] {parts[5]} {parts[6]}') and eval(f'{parts[1]}("{parts[0]}",{parts[2]})')

print(max(registry.values()))
print(largest_value)
