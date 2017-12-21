package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"strings"
)

type point struct {
	x int
	y int
	z int
}

type particle struct {
	id           int
	position     point
	velocity     point
	acceleration point
}

func main() {
	checkArgs()
	filedata := getFileData()
	part1(filedata)
	part2(filedata)
}

func part1(filedata []string) {
	particles := getParticles(filedata)
	numberOfTicks := 1000
	for tick := 0; tick < numberOfTicks; tick++ {
		moveParticles(particles)
	}

	closestParticle := findClosestParticle(point{}, particles)
	fmt.Println("Part 1")
	fmt.Println(" Closest particle is:", closestParticle.id)
}

func part2(filedata []string) {
	particles := getParticles(filedata)
	numberOfTicks := math.MaxInt16

	roundCounter := 0
	historyMap := make(map[int]int)
	for tick := 0; tick < numberOfTicks; tick++ {
		moveParticles(particles)
		particles = removeCollisions(particles)
		historyMap[len(particles)]++

		roundCounter++
		if roundCounter == 10 {
			// check the length for the last 10 rounds
			if len(historyMap) == 1 {
				// the last 10 rounds have had the same length
				break
			}
			roundCounter = 0
			historyMap = make(map[int]int)
		}

	}
	fmt.Println("Part 2")
	fmt.Println(" Particles left:", len(particles))
}

func removeCollisions(particles []particle) []particle {
	toBeDeletedIDs := make([]int, 0)
	for i := 0; i < len(particles); i++ {
		p1 := particles[i]
		for z := 0; z < len(particles); z++ {
			if i == z {
				continue
			}
			p2 := particles[z]
			if p1.position.hasSame(p2.position) {
				toBeDeletedIDs = append(toBeDeletedIDs, p1.id)
				toBeDeletedIDs = append(toBeDeletedIDs, p2.id)
			}
		}

		for _, id := range toBeDeletedIDs {
			// delete all collisions
			particles = deleteParticle(particles, id)
		}
		toBeDeletedIDs = toBeDeletedIDs[:0]
	}
	return particles
}

func (p2 point) hasSame(p1 point) bool {
	return p1.x == p2.x &&
		p1.y == p2.y &&
		p1.z == p2.z
}

func deleteParticle(particles []particle, targetID int) []particle {
	for i, particle := range particles {
		if particle.id == targetID {
			return append(particles[:i], particles[i+1:]...)
		}
	}
	return particles
}

func findClosestParticle(to point, particles []particle) particle {
	closestDistance := math.MaxFloat64
	var closestParticle particle
	for _, particle := range particles {
		distance := particle.position.distance(to)
		if distance < closestDistance {
			closestDistance = distance
			closestParticle = particle
		}
	}

	return closestParticle
}

func (p2 point) distance(p1 point) float64 {
	return math.Sqrt(
		math.Pow(float64(p2.x-p1.x), 2) +
			math.Pow(float64(p2.y-p1.y), 2) +
			math.Pow(float64(p2.z-p1.z), 2))
}

func moveParticles(particles []particle) {
	for i := range particles {
		walkParticle(&particles[i])
	}
}

func walkParticle(p *particle) {
	p.velocity.x += p.acceleration.x
	p.velocity.y += p.acceleration.y
	p.velocity.z += p.acceleration.z

	p.position.x += p.velocity.x
	p.position.y += p.velocity.y
	p.position.z += p.velocity.z
}

func getParticles(data []string) []particle {
	particles := make([]particle, 0)

	for i, line := range data {
		p, v, a := getParticleComponents(line)
		newParticle := particle{
			id:           i,
			position:     p,
			velocity:     v,
			acceleration: a,
		}
		particles = append(particles, newParticle)
	}
	return particles
}

func getParticleComponents(data string) (point, point, point) {
	// p=<283,101,2902>, v=<43,17,415>, a=<1,-1,-28>
	chunks := strings.Fields(data)
	components := make([]point, 0, 3)
	for _, chunk := range chunks {
		parts := strings.Split(chunk, ",")

		xVal := strToInt(parts[0][3:])
		yVal := strToInt(parts[1])
		zVal := strToInt(parts[2][:len(parts[2])-1])

		newPoint := point{
			x: xVal,
			y: yVal,
			z: zVal,
		}
		components = append(components, newPoint)
	}

	return components[0], components[1], components[2]
}

func strToInt(str string) int {
	intVal, err := strconv.Atoi(str)
	if err != nil {
		fmt.Println("Could not convert ", str, "to int. ")
		log.Fatal(err)
	}
	return intVal
}

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide a filename as first and only argument. ")
		fmt.Println(" Example: go run day20.go puzzle.in")
		os.Exit(1)
	}
}

func getFileData() []string {
	filename := os.Args[1]
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0)
	for scanner.Scan() {
		line := scanner.Text()
		filedata = append(filedata, line)
	}
	return filedata
}
