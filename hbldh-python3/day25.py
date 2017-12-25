#!/usr/bin/env python
# -*- coding: utf-8 -*-
from collections import defaultdict

class Turing(object):

    def __init__(self):
        self.registers = defaultdict(lambda: 0)
        self.cursor = 3
        self.state = 'A'

    def run(self, n):
        for k in range(n):
            # if self.state == 'A':
            #     if self.registers[self.cursor] == 0:
            #         self.registers[self.cursor] = 1
            #         self.cursor = (self.cursor + 1) % 6 \
            #             if self.cursor > 0 else 5
            #         self.state = 'B'
            #     else:
            #         self.registers[self.cursor] = 0
            #         self.cursor = (self.cursor - 1) % 6 \
            #             if self.cursor > 0 else 5
            #         self.state = 'B'
            # elif self.state == 'B':
            #     if self.registers[self.cursor] == 0:
            #         self.registers[self.cursor] = 1
            #         self.cursor = (self.cursor - 1) % 6 \
            #             if self.cursor > 0 else 5
            #         self.state = 'A'
            #     else:
            #         self.registers[self.cursor] = 1
            #         self.cursor = (self.cursor + 1) % 6 \
            #             if self.cursor > 0 else 5
            #         self.state = 'A'
            # continue


            if self.state == 'A':
                if self.registers[self.cursor] == 0:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor + 1)
                    self.state = 'B'
                else:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor - 1)
                    self.state = 'E'
            elif self.state == 'B':
                if self.registers[self.cursor] == 0:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor + 1)
                    self.state = 'C'
                else:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor + 1)
                    self.state = 'F'
            elif self.state == 'C':
                if self.registers[self.cursor] == 0:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor - 1)
                    self.state = 'D'
                else:
                    self.registers[self.cursor] = 0
                    self.cursor = (self.cursor + 1)
                    self.state = 'B'
            elif self.state == 'D':
                if self.registers[self.cursor] == 0:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor + 1)
                    self.state = 'E'
                else:
                    self.registers[self.cursor] = 0
                    self.cursor = (self.cursor - 1)
                    self.state = 'C'
            elif self.state == 'E':
                if self.registers[self.cursor] == 0:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor - 1)
                    self.state = 'A'
                else:
                    self.registers[self.cursor] = 0
                    self.cursor = (self.cursor + 1)
                    self.state = 'D'
            elif self.state == 'F':
                if self.registers[self.cursor] == 0:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor + 1)
                    self.state = 'A'
                else:
                    self.registers[self.cursor] = 1
                    self.cursor = (self.cursor + 1)
                    self.state = 'C'
        return sum([self.registers[c] == 1 for c in self.registers.keys()])


def solve_1(data):
    t = Turing()
    out = t.run(12459852)
    return out


def main():
    from _aocutils import ensure_data

    ensure_data(25)
    with open('input_25.txt', 'r') as f:
        data = f.read()
    data = """"""
    print("Part 1: {0}".format(solve_1(data)))



if __name__ == '__main__':
    main()
