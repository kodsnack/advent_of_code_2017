import sys
import logging
from collections import defaultdict

logging.basicConfig(level=logging.DEBUG)

layers = defaultdict(int)

for line in sys.stdin:
    depth, _range = line.split()
    depth = int(depth.replace(":", ""))
    layers[depth] = int(_range)

def severity(depth):
    return depth * layers[depth]

def scanner_pos(depth, t):
    # orkar inte matte den här morgonen
    first = [p for p in range(layers[depth])][1:layers[depth] - 1]
    first.reverse()
    positions = [p for p in range(layers[depth])]
    positions.extend(first)

    # cycle = t // layers[depth]
    # pos_from_origin = t - cycle * layers[depth]
    # pos = pos_from_origin if cycle % 2 == 0 else layers[depth] - (pos_from_origin + 1)
    return positions[t % len(positions)]


def severity_at_time(t):
    total_depth = max(layers.keys())

    _sum = 0
    for depth in range(total_depth + 1):
        if layers[depth]:
            spi = scanner_pos(depth, t)
            # print(depth, spi)
            if spi == 0:
                logging.info(f'Caught at {depth} {spi}')
                _sum += severity(depth)
        t += 1
    return _sum

print(severity_at_time(0))
