package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strings"
)

type Hexagon struct {
	X int
	Y int
	Z int
}

func main() {
	checkUserInput()
	fileData := getFileData()
	part1(fileData)
	part2(fileData)
}

func checkUserInput() {
	if len(os.Args) < 2 {
		fmt.Println("Need filename as argument. ")
		os.Exit(1)
	}
}

func part1(fileData []string) {
	fmt.Println("Part 1:")
	directions := createMapOfDirections(fileData)
	removeOpposites(directions)
	removeEmpty(directions)
	endPoint := getEndPoint(directions)
	zeroHexagon := Hexagon{}
	distance := zeroHexagon.distanceTo(endPoint)
	fmt.Println(" Steps to child-process:", distance)
}

func part2(fileData []string) {
	fmt.Println("Part 2:")
	var furthest float64
	zeroHexagon := Hexagon{}
	walkingHexagon := Hexagon{}
	for _, direction := range fileData {
		walkingHexagon.walk(direction)
		currentDistance := zeroHexagon.distanceTo(walkingHexagon)
		if currentDistance > furthest {
			furthest = currentDistance
		}
	}
	fmt.Println(" The furthest the child-process stepped away was:", furthest)
}

func getFileData() []string {
	filename := os.Args[1]
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Split(line, ",")
		for _, v := range parts {
			filedata = append(filedata, v)
		}
	}
	return filedata
}

func createMapOfDirections(data []string) map[string]int {
	directions := make(map[string]int)
	for _, v := range data {
		directions[v]++
	}
	return directions
}

func removeOpposites(data map[string]int) {
	for k, _ := range data {
		switch k {
		case "n":
			if data[k] > data["s"] {
				data[k] -= data["s"]
				data["s"] = 0
			}
		case "ne":
			if data[k] > data["sw"] {
				data[k] -= data["sw"]
				data["sw"] = 0
			}
		case "se":
			if data[k] > data["nw"] {
				data[k] -= data["nw"]
				data["nw"] = 0
			}
		case "s":
			if data[k] > data["n"] {
				data[k] -= data["n"]
				data["n"] = 0
			}
		case "sw":
			if data[k] > data["ne"] {
				data[k] -= data["ne"]
				data["ne"] = 0
			}
		case "nw":
			if data[k] > data["se"] {
				data[k] -= data["se"]
				data["se"] = 0
			}
		}
	}
}

func removeEmpty(data map[string]int) {
	for k, v := range data {
		if v == 0 {
			delete(data, k)
		}
	}
}

func getEndPoint(data map[string]int) Hexagon {
	hexagon := Hexagon{
		X: 0,
		Y: 0,
		Z: 0,
	}
	for k, v := range data {
		for i := 0; i < v; i++ {
			hexagon.walk(k)
			// same as
			// (&hexagon).walk(k)
			// but hexagon.walk() is shorthand/syntatic sugar for the same thing
		}
	}
	return hexagon
}

func (a Hexagon) distanceTo(b Hexagon) float64 {
	return (math.Abs(float64(a.X-b.X)) + math.Abs(float64(a.Y-b.Y)) + math.Abs(float64(a.Z-b.Z))) / 2
}

func (hexagon *Hexagon) walk(direction string) {
	switch direction {
	case "n":
		hexagon.Y++
		hexagon.Z--
	case "ne":
		hexagon.X++
		hexagon.Z--
	case "se":
		hexagon.X++
		hexagon.Y--
	case "s":
		hexagon.Z++
		hexagon.Y--
	case "sw":
		hexagon.Z++
		hexagon.X--
	case "nw":
		hexagon.Y++
		hexagon.X--
	}
}
