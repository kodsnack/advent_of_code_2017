#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import defaultdict, deque


def is_value(x):
    return x.isdigit() or (x[0] == '-' and x[1:].isdigit())


class Program(object):

    def __init__(self, instructions, pid):
        self.registers = defaultdict(lambda: 0)
        self.registers['p'] = pid
        self.last_played_freq = None
        self.n_sent = 0
        self.received = deque()

        self.instructions = instructions

        self.duet_bind = None
        self.is_waiting = False

    def bind(self, other):
        self.duet_bind = other
        self.duet_bind.duet_bind = self

    def is_deadlock(self):
        if self.is_waiting and not self.received and \
                self.duet_bind.is_waiting and not self.duet_bind.received:
            return True
        return False

    def __getitem__(self, item):
        return int(item) if is_value(item) else self.registers[item]

    def run(self):
        n = 0
        while 0 <= n < len(self.instructions):
            parts = self.instructions[n].split(' ')
            if parts[0] == 'snd':
                self.n_sent += 1
                value = self[parts[1]]
                self.last_played_freq = value
                if self.duet_bind:
                    self.duet_bind.received.appendleft(value)
            elif parts[0] == 'set':
                self.registers[parts[1]] = self[parts[2]]
            elif parts[0] == 'add':
                self.registers[parts[1]] += self[parts[2]]
            elif parts[0] == 'mul':
                self.registers[parts[1]] *= self[parts[2]]
            elif parts[0] == 'mod':
                self.registers[parts[1]] %= self[parts[2]]
            elif parts[0] == 'rcv':
                if self.duet_bind:
                    if self.received:
                        self.registers[parts[1]] = self.received.pop()
                    else:
                        self.is_waiting = True
                        yield
                        if self.received:
                            self.is_waiting = False
                            self.registers[parts[1]] = self.received.pop()
                        else:
                            # Sleep one last time. Deadlock has occurred.
                            yield
                else:
                    if self.registers[parts[1]] != 0:
                        yield self.last_played_freq
            elif parts[0] == 'jgz':
                condition = self[parts[1]]
                if condition > 0:
                    n += self[parts[2]]
                    continue
            else:
                raise ValueError(str(parts))
            n += 1


def solve_1(instructions):
    p = Program(instructions, 0)
    out = next(p.run())
    return out


def solve_2(instructions):
    p0 = Program(instructions, 0)
    p1 = Program(instructions, 1)
    p0.bind(p1)
    p0_run = p0.run()
    p1_run = p1.run()
    while not p0.is_deadlock():
        next(p0_run)
        next(p1_run)
    return p1.n_sent


def main():
    from _aocutils import ensure_data

    ensure_data(18)
    with open('input_18.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data.splitlines())))
    print("Part 2: {0}".format(solve_2(data.splitlines())))


if __name__ == '__main__':
    main()
