import re
import sys
from collections import namedtuple


REG = re.compile(r'\<( *[-\d]+),( *[-\d]+),( *[-\d]+)\>')


Point = namedtuple('Point', ['x', 'y', 'z'])
Particle = namedtuple('Particle', ['p', 'v', 'a'])


def _parse_input(lines):
    particles = []
    for line in lines:
        m = REG.findall(line)
        if not m:
            raise Exception("Line didn't match: {}".format(line))
        assert len(m) == 3
        p, v, a = m
        p = Point(*(int(x) for x in p))
        v = Point(*(int(x) for x in v))
        a = Point(*(int(x) for x in a))
        particles.append(Particle(p, v, a))
    return particles


def _move(particle):
    v = Point(*(x+y for x, y in zip(particle.v, particle.a)))
    p = Point(*(x+y for x, y in zip(particle.p, v)))
    return Particle(p, v, particle.a)


def _dist(part):
    return part.p.x**2 + part.p.y**2 + part.p.z**2


def _find_closest(particles):
    ind = 0
    for i, p in enumerate(particles):
        if _dist(p) < _dist(particles[ind]):
            ind = i
    return ind


def _check_collisions(particles):
    new = []
    for i, p in enumerate(particles):
        found = False
        for j, q in enumerate(particles):
            if i == j:
                continue
            elif p.p == q.p:
                found = True
        if not found:
            new.append(p)
        # else:
        #     print('removing {} due to collision'.format(p.p))
    return new


def _run(particles, enable_collisions=False):
    closest_ind = -1
    times = 0
    while True:
        if enable_collisions:
            particles = _check_collisions(particles)

        for i, particle in enumerate(particles):
            particles[i] = _move(particle)

        ind = _find_closest(particles)
        if closest_ind != ind:
            closest_ind = ind
            times = 0
        else:
            times += 1
        if times > 5000:
            break

    return closest_ind, particles


def part1(particles):
    return _run(particles)[0]


def part2(particles):
    _, parts = _run(particles, enable_collisions=True)
    return len(parts)


def main():
    lines = [line for line in sys.stdin]
    particles = _parse_input(lines)
    print(part1(particles[:]))
    print(part2(particles))


if __name__ == '__main__':
    main()
