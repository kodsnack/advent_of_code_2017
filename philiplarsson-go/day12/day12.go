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

func init() {
	if len(os.Args) != 2 {
		log.Fatal("Please provide filename as argument to this program. ")
	}
}

func main() {
	filedata := readFileData()
	part1(filedata)
	part2(filedata)
}

func readFileData() []string {
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

func part1(filedata []string) {
	fmt.Println("Part 1")
	zeroGroup := getAllProgramsInGroup(0, filedata)
	fmt.Println(" Programs in group 0:", len(zeroGroup))
}

func part2(filedata []string) {
	fmt.Println("Part 2")
	groups := make([]map[int]bool, 0)
	alreadyExists := false
	for id := 0; id < len(filedata); id++ {
		for _, group := range groups {
			_, exists := group[id]
			if exists {
				alreadyExists = true
				continue
			}
		}
		if !alreadyExists {
			newGroup := getAllProgramsInGroup(id, filedata)
			groups = append(groups, newGroup)
		}
		alreadyExists = false
	}
	fmt.Println(" Total number of groups:", len(groups))
}

func getAllProgramsInGroup(groupNbr int, filedata []string) map[int]bool {
	group := make(map[int]bool)
	weight := math.MinInt16
	for weight != len(group) {
		// Run multiple times so all connections can be made
		weight = len(group)
		for _, line := range filedata {
			connectedNumbers := getConnectedNumbers(line)
			if sliceContains(groupNbr, connectedNumbers) ||
				numberIsInMap(connectedNumbers, group) {
				addNumbersToMap(connectedNumbers, group)
			}
		}
	}
	return group
}

func getConnectedNumbers(line string) []int {
	chunks := strings.Fields(line)
	connectedNumbers := make([]int, 0)

	// Add first (before <->)
	firstNbr, err := strconv.Atoi(chunks[0])
	if err != nil {
		log.Fatal(err)
	}

	connectedNumbers = append(connectedNumbers, firstNbr)
	for i := 2; i < len(chunks); i++ {
		chunk := strings.TrimSuffix(chunks[i], ",")
		nbr, err := strconv.Atoi(chunk)
		if err != nil {
			log.Fatal(err)
		}
		connectedNumbers = append(connectedNumbers, nbr)
	}

	return connectedNumbers
}

func sliceContains(needle int, haystack []int) bool {
	for _, straw := range haystack {
		if needle == straw {
			return true
		}
	}
	return false
}

func numberIsInMap(numbers []int, numberMap map[int]bool) bool {
	for _, nbr := range numbers {
		_, ok := numberMap[nbr]
		if ok {
			return true
		}
	}
	return false
}

func addNumbersToMap(numbers []int, numberMap map[int]bool) {
	for _, nbr := range numbers {
		numberMap[nbr] = true
	}
}
