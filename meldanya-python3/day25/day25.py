import re
from collections import defaultdict

NUM_RE = re.compile(r'(\d+)')


def _example():
    n = 6
    states = {
        'A': {0: (1, 'R', 'B'), 1: (0, 'L', 'B')},
        'B': {0: (1, 'L', 'A'), 1: (1, 'R', 'A')},
    }
    return 'A', n, states


def _input():
    n = 12172063
    states = {
        'A': {0: (1, 'R', 'B'), 1: (0, 'L', 'C')},
        'B': {0: (1, 'L', 'A'), 1: (1, 'L', 'D')},
        'C': {0: (1, 'R', 'D'), 1: (0, 'R', 'C')},
        'D': {0: (0, 'L', 'B'), 1: (0, 'R', 'E')},
        'E': {0: (1, 'R', 'C'), 1: (1, 'L', 'F')},
        'F': {0: (1, 'L', 'E'), 1: (1, 'R', 'A')},
    }
    return 'A', n, states


def part1(start, n, states):
    tape = defaultdict(lambda: 0)
    state = states[start]
    curr = 0
    for i in range(n):
        write, dir_, next_ = state[tape[curr]]
        tape[curr] = write
        curr += 1 if dir_ == 'R' else -1
        state = states[next_]
    return sum([v for i, v in tape.items()])


def main():
    # start, n, states = _example()
    start, n, states = _input()
    print(part1(start, n, states))


if __name__ == '__main__':
    main()
