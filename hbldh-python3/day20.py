#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import itertools


def _parse_particles(data):
    particles = []
    p = re.findall('p=<([-\d]+,[-\d]+,[-\d]+)>', data)
    v = re.findall('v=<([-\d]+,[-\d]+,[-\d]+)>', data)
    a = re.findall('a=<([-\d]+,[-\d]+,[-\d]+)>', data)
    for i, (pos, vel, acc) in enumerate(zip(p, v, a)):
        particles.append(list(itertools.chain([i, ],
                                              map(int, pos.split(',')),
                                              map(int, vel.split(',')),
                                              map(int, acc.split(',')))))
    return particles


def _manhattan_norm(x):
    return sum(map(abs, x[1:4]))


def _update_particles(particles):
    for p in particles:
        # Velocity update
        p[4] += p[7]
        p[5] += p[8]
        p[6] += p[9]
        # Position update
        p[1] += p[4]
        p[2] += p[5]
        p[3] += p[6]
    return particles


def _remove_collisons(particles):
    particles.sort(key=lambda x: x[1:4])
    surviving_particles = []
    for position, p_present in itertools.groupby(
            particles, lambda x: tuple(x[1:4])):
        ps = [p for p in p_present]
        if len(ps) > 1:
            # Collision.
            continue
        else:
            surviving_particles += ps
    return surviving_particles


def solve_1(data, n=500):
    particles = _parse_particles(data)
    particles.sort(key=_manhattan_norm)
    i = 0
    last_best = []
    while True:
        particles = _update_particles(particles)
        particles.sort(key=_manhattan_norm)
        i += 1
        last_best.append(particles[0][0])
        if len(last_best) > n and len(set(last_best[-n:])) == 1:
            break
        # print(f"[{i:04d}] Closest particle: {particles[0]}")
    return particles[0][0]


def solve_2(data, n=500):
    particles = _parse_particles(data)
    particles.sort(key=_manhattan_norm)
    i = 0
    n_particles = []
    while True:
        particles = _update_particles(particles)
        particles = _remove_collisons(particles)
        particles.sort(key=_manhattan_norm)
        i += 1
        n_particles.append(len(particles))
        if len(n_particles) > n and len(set(n_particles[-n:])) == 1:
            break
        # print(f"[{i:04d}] N Particles: {n_particles[-1]}")
    return n_particles[-1]


def main():
    from _aocutils import ensure_data

    ensure_data(20)
    with open('input_20.txt', 'r') as f:
        data = f.read()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
