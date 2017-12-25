import sys
import time
from collections import defaultdict
from multiprocessing import Process, Pipe, Event


def _try_int(v):
    try:
        return int(v.strip())
    except ValueError:
        return v.strip()


def _parse_instructions(lines):
    instructions = []
    for l in lines:
        typ = l[:3]
        if typ == 'snd' or typ == 'rcv':
            dst = _try_int(l[4:])
            instructions.append((typ, dst))
        else:
            regs = l[4:].split(' ')
            dst, src = _try_int(regs[0]), _try_int(regs[1])
            instructions.append((typ, dst, src))
    return instructions


def _get_value(r, regs):
    if type(r) == int:
        return r
    return regs[r]


def part1(instructions):
    regs = defaultdict(lambda: 0)
    last_played = None
    i = 0
    while i >= 0 and i < len(instructions):
        instruction = instructions[i]
        if len(instruction) == 3:
            t, dst, src = instruction
        else:
            t, dst = instruction

        if t == 'snd':
            last_played = _get_value(dst, regs)
        elif t == 'set':
            regs[dst] = _get_value(src, regs)
        elif t == 'add':
            regs[dst] = _get_value(dst, regs) + _get_value(src, regs)
        elif t == 'mul':
            regs[dst] = _get_value(dst, regs) * _get_value(src, regs)
        elif t == 'mod':
            regs[dst] = _get_value(dst, regs) % _get_value(src, regs)
        elif t == 'rcv':
            if _get_value(dst, regs) != 0:
                regs[dst] = last_played
                break
        elif t == 'jgz':
            if _get_value(dst, regs) > 0:
                i += _get_value(src, regs)
            else:
                i += 1
        if t != 'jgz':
            i += 1
    return last_played


def _run(instructions, pid, pipe, ev):
    regs = defaultdict(lambda: 0)
    regs['p'] = pid
    i = 0
    n = 0
    while i >= 0 and i < len(instructions):
        instruction = instructions[i]
        if len(instruction) == 3:
            t, dst, src = instruction
        else:
            t, dst = instruction

        if t == 'snd':
            v = _get_value(dst, regs)
            n += 1
            pipe.send(v)
        elif t == 'set':
            regs[dst] = _get_value(src, regs)
        elif t == 'add':
            regs[dst] = _get_value(dst, regs) + _get_value(src, regs)
        elif t == 'mul':
            regs[dst] = _get_value(dst, regs) * _get_value(src, regs)
        elif t == 'mod':
            regs[dst] = _get_value(dst, regs) % _get_value(src, regs)
        elif t == 'rcv':
            ev.set()
            tmp = pipe.recv()
            if tmp is not None:
                regs[dst] = tmp
            else:
                break
            ev.clear()
        elif t == 'jgz':
            if _get_value(dst, regs) > 0:
                i += _get_value(src, regs)
            else:
                i += 1
        if t != 'jgz':
            i += 1
    print('pid {} sent {} times'.format(pid, n))


def part2(instructions):
    pipe0, pipe1 = Pipe()
    ev0, ev1 = Event(), Event()
    p0 = Process(target=_run, args=(instructions, 0, pipe0, ev0))
    p1 = Process(target=_run, args=(instructions, 1, pipe1, ev1))
    p0.start()
    p1.start()

    i = 0
    while True:
        if ev0.is_set() and ev1.is_set():
            i += 1
        if i > 5:
            break
        time.sleep(0.2)

    pipe0.send(None)
    pipe1.send(None)
    pipe0.close()
    pipe1.close()

    p0.join()
    p1.join()


def main():
    lines = [line for line in sys.stdin]
    instructions = _parse_instructions(lines)
    print(part1(instructions))
    part2(instructions)


if __name__ == '__main__':
    main()
