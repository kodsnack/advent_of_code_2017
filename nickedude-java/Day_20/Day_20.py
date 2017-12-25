
class Particle:

    def __init__(self, px, py, pz, vx, vy, vz, ax, ay, az, myId) :
        self.id = myId

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

        return(self.px,self.py,self.pz)

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
    particles.append(Particle(l[0],l[1],l[2],l[3],l[4],l[5],l[6],l[7],l[8],i))


minimum = 0
for i in range(0,len(particles)):
    ax = abs(particles[i].ax)
    axMin = abs(particles[minimum].ax)
    ay = abs(particles[i].ay)
    ayMin = abs(particles[minimum].ay)
    az = abs(particles[i].az)
    azMin = abs(particles[minimum].az)
    a = ax + ay + az
    aMin = axMin + ayMin + azMin
    if a < aMin:
        minimum = i

print(minimum)

print("Particles before: " + str(len(particles)))

for j in range(0,10000):       #loop until everyone are moving out from the middle
    cords = {}              #maps coordinates housing a particle to particle id
    remove = set()          #id's of particles which are to be removed
    for i in range(0,len(particles)):
        triple = particles[i].move()
        if triple in cords:
            remove.add(i)
            remove.add(cords[triple])
        else:
            cords[triple] = i
    #print("Cords: " + str(cords))
    #print("To remove: " + str(remove))

    temp = []
    for i in range(0,len(particles)):
        if i not in remove:
            temp.append(particles[i])
    particles = temp

print("Particles after: " + str(len(particles)))
