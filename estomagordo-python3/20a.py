def dist(particle):
    return abs(particle[0]) + abs(particle[1]) + abs(particle[3])

def score(particle):
    accsum = abs(particle[6]) + abs(particle[7]) + abs(particle[8])
    
    velsum = 0
    for x in range(3, 6):
        prod = (particle[x] * particle[x + 3])
        sign = -1 if prod < 0 else 1
        velsum += particle[x] * sign

    return (accsum, velsum, dist(particle))

def solve(particles):
    scored = sorted([[score(particle), i] for i, particle in enumerate(particles)])
    return scored[0][1]

with open('input_20.txt', 'r') as f:
    particles = []
    for line in f.readlines():
        particle = []
        segments = line.split()
        for segment in segments:
            x, y, z = list(map(int, segment.rstrip(',')[3:-1].split(',')))
            particle += [x, y, z]
        particles.append(particle)
    print(solve(particles))
