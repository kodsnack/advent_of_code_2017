import sys
import re
from collections import namedtuple, defaultdict

Particle = namedtuple('Particle', 'position velocity acceleration')

def step1(particles):
    min_acc = float('inf')
    min_idx = -1
    min_point = None
    for i, particle in enumerate(particles):
        a1, a2, a3 = particle.acceleration
        acc = abs(a1) + abs(a2) + abs(a3)
        if acc <= min_acc:
            # Should consider velocity and initial position to be certain
            # in case acceleration is equal. But this is good enough for
            # the test input
            min_acc = acc
            min_idx = i
    return min_idx


def step2(particles):
    particles_map = defaultdict(list)
    for particle in particles:
        particles_map[particle.position] += [particle]

    for i in range(0, 1000):
        new_particles_map = defaultdict(list)
        for pos in particles_map.keys():
            particles_at_pos = particles_map[pos]
            if len(particles_at_pos) > 1:
                continue # collision
            p = particles_at_pos[0]
            x, y, z = p.position
            dx, dy, dz = p.velocity
            dax, day, daz = p.acceleration
            p2 = Particle(
                    (x + dx + dax, y + dy + day, z + dz + daz), 
                    (dx + dax, dy + day, dz + daz),
                    p.acceleration
                )
            new_particles_map[p2.position] += [p2]
        particles_map = new_particles_map

    return len(particles_map)


def get_input():
    res = []
    for s in sys.stdin:
        p, v, a = re.match(r'p=<([^>]*)>, v=<([^>]*)>, a=<([^>]*)>', s).groups()
        res += [Particle(ints(p), ints(v), ints(a))]
    return res


def ints(s):
    return tuple(map(int, s.split(',')))


particles = get_input()
print(step1(particles))
print(step2(particles))
