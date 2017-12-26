import re
import sys
from collections import namedtuple

Layer = namedtuple('Layer', 'depth range')

def step1(layers):
    return sum(layer.depth * layer.range for layer in run(layers, 0))


def step2(layers):
    i = 0
    while True:
        valid = True
        for caught_layer in run(layers, i):
            valid = False
            break
        if valid:
            return i
        i += 1


def run(layers, start_time):
    for layer in layers:
        time = start_time + layer.depth
        layer_pos = time % (2 * layer.range - 2)
        if layer_pos == 0:
            yield layer



def read_input():
    res = []
    for s in sys.stdin:
        depth, _range = re.match(r'(\d+): (\d+)', s).groups()
        res += [Layer(int(depth), int(_range))]
    return res


layers = read_input()    
print(step1(layers))
print(step2(layers))
