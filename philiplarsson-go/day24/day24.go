package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type connection struct {
	aValue       string
	bValue       string
	aConnections []*connection
	bConnections []*connection
	strength     int
	visited      bool
}

var largest int

func main() {
	checkArgs()
	filedata := getFileData()
	connections := getConnections(filedata)
	part1(connections)
	part2(connections)
}

func part1(connections []connection) {
	var currentNode connection
	for i := range connections {
		currentNode = connections[i]
		if currentNode.aValue == "0" || currentNode.bValue == "0" {
			// only start with zero based connections
			connections[i].setVisited()
			getMaxValueFor(&connections[i], 0, "a")
		}
	}
	fmt.Println("Part 1")
	fmt.Println(" Max strength:", largest)
}

func part2(connections []connection) {
	largest = 0
	var currentNode connection
	bridgeLengths := make(map[int]int)
	// bridgeStrength is length : strength
	for i := range connections {
		currentNode = connections[i]
		if currentNode.aValue == "0" || currentNode.bValue == "0" {
			// only start with zero based connections
			connections[i].setVisited()
			bridgeLengths[1] = currentNode.strength
			getMaxStrengthFor(&connections[i], 0, "a", bridgeLengths, 0)
		}
	}

	largestBridge := 0
	for length := range bridgeLengths {
		if length > largestBridge {
			largestBridge = length
		}
	}
	fmt.Println("Part 2")
	fmt.Println(" Largest bridge has strength", bridgeLengths[largestBridge])
}

func getMaxValueFor(currentNode *connection, currentStrength int, cameFrom string) {
	// used for Part 1
	currentStrength += currentNode.strength

	if currentStrength > largest {
		largest = currentStrength
	}

	if currentNode.aValue == currentNode.bValue {
		cameFrom = ""
	}

	if cameFrom != "a" {
		// We used connection port B before, now go through A ports
		for i := range currentNode.aConnections {
			if !currentNode.aConnections[i].visited {
				// if current is not visited
				currentNode.aConnections[i].visited = true
				if currentNode.aConnections[i].aValue == currentNode.aValue {
					// if the A port is the same as the current a value we use A
					getMaxValueFor(currentNode.aConnections[i], currentStrength, "a")
				} else {
					getMaxValueFor(currentNode.aConnections[i], currentStrength, "b")
				}
				currentNode.aConnections[i].visited = false
			}
		}
	}

	if cameFrom != "b" {
		// We used connection port A before, now go through B ports
		for i := range currentNode.bConnections {
			if !currentNode.bConnections[i].visited {
				// if current is not visited
				currentNode.bConnections[i].visited = true
				if currentNode.bConnections[i].bValue == currentNode.bValue {
					// if the B port is the same as the current B value we use B
					getMaxValueFor(currentNode.bConnections[i], currentStrength, "b")
				} else {
					getMaxValueFor(currentNode.bConnections[i], currentStrength, "a")
				}
				currentNode.bConnections[i].visited = false
			}
		}
	}
}

func getMaxStrengthFor(currentNode *connection, currentStrength int, cameFrom string, bridgeLengths map[int]int, length int) {
	// Part 2
	length++
	currentStrength += currentNode.strength
	if currentStrength > bridgeLengths[length] {
		bridgeLengths[length] = currentStrength
	}

	if currentStrength > largest {
		largest = currentStrength
	}

	if currentNode.aValue == currentNode.bValue {
		cameFrom = ""
	}

	if cameFrom != "a" {
		// We used connection port B before, now go through A ports
		for i := range currentNode.aConnections {
			if !currentNode.aConnections[i].visited {
				// if current is not visited
				currentNode.aConnections[i].visited = true
				if currentNode.aConnections[i].aValue == currentNode.aValue {
					// if the A port is the same as the current a value we use A
					getMaxStrengthFor(currentNode.aConnections[i], currentStrength, "a", bridgeLengths, length)
				} else {
					getMaxStrengthFor(currentNode.aConnections[i], currentStrength, "b", bridgeLengths, length)
				}
				currentNode.aConnections[i].visited = false
			}
		}
	}

	if cameFrom != "b" {
		// We used connection port A before, now go through B ports
		for i := range currentNode.bConnections {
			if !currentNode.bConnections[i].visited {
				// if current is not visited
				currentNode.bConnections[i].visited = true
				if currentNode.bConnections[i].bValue == currentNode.bValue {
					// if the B port is the same as the current B value we use B
					getMaxStrengthFor(currentNode.bConnections[i], currentStrength, "b", bridgeLengths, length)
				} else {
					getMaxStrengthFor(currentNode.bConnections[i], currentStrength, "a", bridgeLengths, length)
				}
				currentNode.bConnections[i].visited = false
			}
		}
	}
}

func (conn *connection) print() {
	fmt.Printf(" Connection %s (visited:%t) (address: %p)\n", conn.toString(), conn.visited, conn)
	fmt.Printf("  has %d a connections\n", len(conn.aConnections))
	var aConn, bConn *connection
	for i := range conn.aConnections {
		aConn = conn.aConnections[i]
		fmt.Printf("   - %s/%s (visited:%t) (address: %p)\n", aConn.aValue, aConn.bValue, aConn.visited, conn.aConnections[i])
	}
	fmt.Printf("  has %d b connections\n", len(conn.bConnections))
	for i := range conn.bConnections {
		bConn = conn.bConnections[i]
		fmt.Printf("   - %s/%s (visited:%t) (address: %p)\n", bConn.aValue, bConn.bValue, bConn.visited, conn.bConnections[i])
	}
}

func (conn *connection) setVisited() {
	conn.visited = true
}

func (conn connection) toString() string {
	return fmt.Sprintf("%s/%s", conn.aValue, conn.bValue)
}

func getConnections(data []string) []connection {
	connections := make([]connection, 0)
	for _, line := range data {
		connectionValues := strings.Split(line, "/")
		aAsInt, err := strconv.Atoi(connectionValues[0])
		if err != nil {
			log.Fatal(err)
		}

		bAsInt, err := strconv.Atoi(connectionValues[1])
		if err != nil {
			log.Fatal(err)
		}

		strength := aAsInt + bAsInt
		newConnection := connection{
			aValue:       connectionValues[0],
			bValue:       connectionValues[1],
			aConnections: make([]*connection, 0, 100),
			bConnections: make([]*connection, 0, 100),
			strength:     strength,
			visited:      false,
		}
		connections = append(connections, newConnection)
	}

	bindConnections(connections)
	return connections
}

func bindConnections(connections []connection) {
	for i := 0; i < len(connections); i++ {
		for x := i; x < len(connections); x++ {
			if i == x {
				continue
			}
			if connections[i].aValue == "0" && connections[x].aValue == "0" {
				// don't connect 0 valued connections
				continue
			}

			if connections[i].aValue == connections[x].aValue {
				connections[i].aConnections = append(connections[i].aConnections, &connections[x])
				connections[x].aConnections = append(connections[x].aConnections, &connections[i])
			} else if connections[i].aValue == connections[x].bValue {
				connections[i].aConnections = append(connections[i].aConnections, &connections[x])
				connections[x].bConnections = append(connections[x].bConnections, &connections[i])
			} else if connections[i].bValue == connections[x].aValue {
				connections[i].bConnections = append(connections[i].bConnections, &connections[x])
				connections[x].aConnections = append(connections[x].aConnections, &connections[i])
			} else if connections[i].bValue == connections[x].bValue {
				connections[i].bConnections = append(connections[i].bConnections, &connections[x])
				connections[x].bConnections = append(connections[x].bConnections, &connections[i])
			}
		}
	}
}

// ------------------- Regular programs check and file reading -------------------
func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide a filename to a file that contains the puzzle input as first argument. ")
		fmt.Println(" Example: go run day24.go puzzle.in")
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
