package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strings"
)

type hex struct {
	x int
	y int
	z int
}

func Newhex() hex {
	var h hex
	h.x = 0
	h.y = 0
	h.z = 0
	return h
}

func distance(a hex, b hex) int {
	return (int(math.Abs(float64(a.x-b.x))+math.Abs(float64(a.y-b.y))+math.Abs(float64(a.z-b.z))) / 2)
}

func walk(pos hex, dir string) hex {
	newpos := pos
	switch dir {
	case "nw":
		newpos.y++
		newpos.z--
	case "n":
		newpos.x++
		newpos.z--
	case "ne":
		newpos.x++
		newpos.y--
	case "se":
		newpos.y--
		newpos.z++
	case "s":
		newpos.x--
		newpos.z++
	case "sw":
		newpos.x--
		newpos.y++
	}
	return newpos
}

func readPathFromFile(f string) string {
	file, err := os.Open(f)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	reader := bufio.NewReader(file)
	// Read all bytes to buffer
	path, _ := reader.ReadString(0x00)
	return path
}

func main() {
	pathstring := readPathFromFile("input.txt")
	//pathstring := "ne,ne,ne" // is 3 steps away.
	//pathstring := "ne,ne,sw,sw" // is 0 steps away (back where you started).
	//pathstring := "ne,ne,s,s" // is 2 steps away (se,se).
	//pathstring := "se,sw,se,sw,sw" is 3 steps away (s,s,sw).
	path := strings.Split(pathstring, ",")
	origo := Newhex()
	position := origo
	steps := 0
	maxDist := 0

	for _, w := range path {
		position = walk(position, w)
		dist := distance(position, origo)
		if dist > maxDist {
			maxDist = dist
		}
		steps++
	}
	fmt.Println("After walking", steps, "steps the child ended up at", position, "which is", distance(position, origo), "steps away after having strayed", maxDist, "steps away at the farthest")
}
