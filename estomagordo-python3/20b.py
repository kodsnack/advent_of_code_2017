from collections import defaultdict

def solve(particles):
    repeats = 0
    magic_repeat_limit = 50

    while True:
        count = len(particles)
        positions = defaultdict(list)        
        
        for i, particle in enumerate(particles):
            particle[3] += particle[6]
            particle[4] += particle[7]
            particle[5] += particle[8]
            particle[0] += particle[3]
            particle[1] += particle[4]
            particle[2] += particle[5]
            
            positions[(particle[0], particle[1], particle[2])].append(i)            

        deleting = []
        
        for value in positions.values():
            if len(value) > 1:
                deleting += value
                
        deleting.sort(reverse = True)
        
        for index in deleting:
            del particles[index]
            
        if len(particles) == count:
            repeats += 1
        else:
            repeats = 0
        
        if repeats == magic_repeat_limit:
            break        
            
    return count

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
