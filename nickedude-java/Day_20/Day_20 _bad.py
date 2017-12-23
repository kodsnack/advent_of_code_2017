
class Particle:

    def __init__(self, px, py, pz, vx, vy, vz, ax, ay, az) :
        self.px = int(px)
        self.py = int(py)
        self.pz = int(pz)

        self.vx = int(vx)
        self.vy = int(vy)
        self.vz = int(vz)

        self.ax = int(ax)
        self.ay = int(ay)
        self.az = int(az)

    def move(self):
        self.vx = self.vx + self.ax
        self.vy = self.vy + self.ay
        self.vz = self.vz + self.az

        self.px = self.px + self.vx
        self.py = self.py + self.vy
        self.pz = self.pz + self.vz

    def distance(self):
        return (abs(self.px) + abs(self.py) + abs(self.pz))

def trim(s):
    s = str(s)
    numbers = []
    i = 0

    while i < len(s):
        if (s[i].isdigit()) | (s[i] == '-'):
            j = i
            i += 1
            while s[i].isdigit():
                i += 1
            numbers.append(int(s[j:i]))
        else:
            i += 1
    return numbers


inputFile = open('Day_20.txt')
inputList = inputFile.readlines()
particles = []
for i in range(0,len(inputList)):
    l = trim(inputList[i])
    particles.append(Particle(l[0],l[1],l[2],l[3],l[4],l[5],l[6],l[7],l[8]))


for i in range(0,1000000):
    if i % 100000 == 0:
        print(i)
    for j in range(0,len(particles)):
        particles[j].move()

minIndex = 0
for i in range(1,len(particles)):
    if particles[i].distance() < particles[minIndex].distance():
        minIndex = i

print(minIndex)

