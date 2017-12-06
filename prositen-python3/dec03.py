class SpiralMemoryAlgoritm(object):
    MAX_SQUARE = 1000

    ODD_SQUARES = [x * x for x in range(1, MAX_SQUARE, 2)]

    E_LINE = [int(x ** 2 + 0.5 * x + 0.5) for x in range(-1, MAX_SQUARE, 2)]
    N_LINE = [int(x ** 2 + 1.5 * x + 1.5) for x in range(-1, MAX_SQUARE, 2)]
    W_LINE = [int(x ** 2 + 2.5 * x + 2.5) for x in range(-1, MAX_SQUARE, 2)]
    S_LINE = [int(x ** 2 + 3.5 * x + 3.5) for x in range(-1, MAX_SQUARE, 2)]

    CARDINALITIES = [[int(x ** 2 + m * x + m) for x in range(-1, 1000, 2)]
                     for m in (0.5, 1.5, 2.5, 3.5)
                     ]

    def spiral_steps(self, cell):
        for tier, square in enumerate(self.ODD_SQUARES):
            if cell <= square:
                steps = min([abs(cell - x) for x in
                             [self.CARDINALITIES[direction][tier] for direction in [0, 1, 2, 3]]])
                return steps + tier


class SpiralMemory(object):
    def __init__(self):
        self.cells = dict()
        self.pos_x = 0
        self.pos_y = 0
        self.next_dir = None

    @staticmethod
    def next_direction():
        mul = 1
        while True:
            for x in [(1, 0)] * mul:
                yield x
            for x in [(0, 1)] * mul:
                yield x
            mul += 1
            for x in [(-1, 0)] * mul:
                yield x
            for x in [(0, -1)] * mul:
                yield x
            mul += 1

    def neighbour_values(self, default):
        return [self.cells.get((self.pos_x + dx, self.pos_y + dy), default)
                for dx in (-1, 0, 1) for dy in (-1, 0, 1)]

    def update_cell(self, value):
        self.cells[(self.pos_x, self.pos_y)] = value

    def next_cell(self):
        d = next(self.next_dir)
        self.pos_x += d[0]
        self.pos_y += d[1]

    def reset(self):
        self.pos_x = 0
        self.pos_y = 0
        self.cells = {
            (0, 0): 1
        }
        self.next_dir = self.next_direction()

    def spiral_steps(self, cell):
        self.reset()
        for i in range(2, cell + 1):
            self.next_cell()
            self.update_cell(i)

        return abs(self.pos_x) + abs(self.pos_y)

    def cell(self, x=None, y=None):
        if x is None:
            x = self.pos_x
        if y is None:
            y = self.pos_y
        return self.cells.get((x, y), None)

    def stress_test(self, cell, break_at_larger=False):
        self.reset()
        for i in range(2, cell + 1):
            self.next_cell()
            next_value = sum(self.neighbour_values(0))
            self.update_cell(next_value)
            if next_value > cell and break_at_larger:
                return next_value

    def print(self):
        minx = min(self.cells.keys(), key=lambda a: a[0])[0]
        miny = min(self.cells.keys(), key=lambda a: a[1])[1]
        maxx = max(self.cells.keys(), key=lambda a: a[0])[0]
        maxy = max(self.cells.keys(), key=lambda a: a[1])[1]

        mexw = len(str(max(self.cells.values()))) + 1
        for y in range(miny - 1, maxy + 1):
            for x in range(minx - 1, maxx + 1):
                print(str(self.cell(x, -y)).rjust(mexw, ' '), end='')
            print()


if __name__ == '__main__':
    puzzle_input = 325489
    SM = SpiralMemory()
    print("{} steps needed for input {}".format(SM.spiral_steps(puzzle_input), puzzle_input))
    print("First written larger value is {}".format(SM.stress_test(puzzle_input, break_at_larger=True)))