import sys
from collections import defaultdict
from enum import Enum

class State(Enum):
    CLEAN = 1
    WEAKENED = 2
    INFECTED = 3
    FLAGGED = 4


class Direction(Enum):
    RIGHT = 1
    LEFT = 2
    STRAIGHT = 3
    REVERSE = 4


def step1(inp):
    state_map = {State.INFECTED: State.CLEAN, State.CLEAN: State.INFECTED}
    direction_map = {State.INFECTED: Direction.RIGHT, State.CLEAN: Direction.LEFT}
    return run(state_map, direction_map, 10000)


def step2(inp):
    state_map = {State.CLEAN: State.WEAKENED, 
            State.WEAKENED: State.INFECTED,
            State.INFECTED: State.FLAGGED,
            State.FLAGGED: State.CLEAN}
    direction_map = {State.INFECTED: Direction.RIGHT, 
            State.CLEAN: Direction.LEFT,
            State.WEAKENED: Direction.STRAIGHT,
            State.FLAGGED: Direction.REVERSE}
    return run(state_map, direction_map, 10000000)


def run(state_map, direction_map, iterations):
    x = len(inp) // 2
    y = x
    dx = 0
    dy = -1
    ans = 0

    grid = defaultdict(lambda: defaultdict(lambda: State.CLEAN))
    for i in range(0, len(inp)):
        for j in range(0, len(inp[0])):
            grid[i][j] = State.CLEAN if inp[i][j] == '.' else State.INFECTED

    for _ in range(0, iterations):
        direction = direction_map[grid[y][x]]
        if direction == Direction.RIGHT:
            dx, dy = -dy, dx
        elif direction == Direction.LEFT:
            dx, dy = dy, -dx
        elif direction == Direction.REVERSE:
            dx, dy = -dx, -dy
        else:
            assert(direction == Direction.STRAIGHT)
        new_state = state_map[grid[y][x]]
        if grid[y][x] != State.INFECTED and new_state == State.INFECTED:
            ans += 1

        grid[y][x] = new_state
        x += dx
        y += dy

    return ans


inp = [s.strip() for s in sys.stdin]
print(step1(inp))
print(step2(inp))
