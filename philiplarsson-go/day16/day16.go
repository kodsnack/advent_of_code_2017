package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"strings"
	"time"
)

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide a filename to the puzzle input as first argument. ")
		fmt.Println(" Example: go run day16.go puzzle.in")
		os.Exit(1)
	}
}
func main() {
	checkArgs()
	filedata := getFileData()
	part1(filedata)
	part2(filedata)
}

func part1(danceMoves []string) {
	startTime := time.Now()
	programs := createPrograms()
	doDanceMoves(&programs, danceMoves)

	fmt.Println("Part 1")
	timeDiffEnd := time.Now().Sub(startTime)
	fmt.Printf(" Order after dance: %s (took %.4f seconds)\n", toString(programs), timeDiffEnd.Seconds())
}

func part2(danceMoves []string) {
	startTime := time.Now()
	programs := createPrograms()
	oneBillion := int(1 * math.Pow(10, 9))
	history := make(map[string]int)

	for i := 0; i < oneBillion; i++ {
		doDanceMoves(&programs, danceMoves)

		lastIndex, ok := history[toString(programs)]
		if ok {
			// The idea is as follows
			// We store all programs in a map. This is the history.
			// In the "history-map" we also store in which index we saw that program.
			// If we see the same program again, we can assume that we will se it in the future in as many steps.
			// Therefore we jump forward the same distance as it was we saw the last in.

			// Example:
			// If ok is true, we have seen this exact program before.
			// Let say that the index is 61, and we saw this before in index 1.
			// We therefore jump forward to next time we will see the same, which is 61-1 steps forward.
			// Index becomes 61 + 60 = 121
			// We have an if check to make sure that we won't create an index that is above one billion.
			// In that case we might miss some dances.

			// Uncomment the following to see each steps
			// fmt.Println("We have seen this before.")
			// fmt.Println(" Last time was in index:", lastIndex)
			// fmt.Println(" This index is:", i)
			// fmt.Println(" The differece is", i-lastIndex)
			// fmt.Println(" History is:", toString(programs))

			if (i + (i - lastIndex)) < oneBillion {
				i += (i - lastIndex)
				// fmt.Println("Changed index to", i)
			}
		}
		history[toString(programs)] = i
	}
	fmt.Println("Part 2")
	timeDiffEnd := time.Now().Sub(startTime)
	fmt.Printf(" Order after long dance: %s (took %.4f seconds)\n", toString(programs), timeDiffEnd.Seconds())
}

func doDanceMoves(programs *[16]string, danceMoves []string) {
	for _, danceMove := range danceMoves {
		if strings.HasPrefix(danceMove, "s") {
			spin(programs, danceMove)
		} else if strings.HasPrefix(danceMove, "x") {
			exchange(programs, danceMove)
		} else if strings.HasPrefix(danceMove, "p") {
			swapPartner(programs, danceMove)
		}
	}
}

func spin(programs *[16]string, spinInstruction string) {
	lastPartOfInstruction := spinInstruction[1:]
	nbrThatShouldBeSpinned, err := strconv.Atoi(lastPartOfInstruction)
	if err != nil {
		fmt.Println("Could not convert", lastPartOfInstruction)
		log.Fatal(err)
	}
	programsToBeSpinned := make([]string, nbrThatShouldBeSpinned)
	copy(programsToBeSpinned, programs[len(programs)-nbrThatShouldBeSpinned:])
	// create copy of programs to be spinned. If we just use a slice we will get a reference
	// to the last elements and when we move everything forward we will be at the wrong programs.

	for i := len(programs) - 1; i >= nbrThatShouldBeSpinned; i-- {
		// Move every program forward
		(*programs)[i] = (*programs)[i-nbrThatShouldBeSpinned]
	}

	for i := 0; i < len(programsToBeSpinned); i++ {
		// Add the programs at the beginning
		(*programs)[i] = programsToBeSpinned[i]
	}
}

func exchange(programs *[16]string, spinInstruction string) {
	lastPartOfInstruction := spinInstruction[1:]
	chunks := strings.Split(lastPartOfInstruction, "/")
	programIndexes := make([]int, 0)
	for _, chunk := range chunks {
		// transform all indexes to ints
		programIndex, err := strconv.Atoi(chunk)
		if err != nil {
			fmt.Println("Could not convert", chunk)
			log.Fatal(err)
		}
		programIndexes = append(programIndexes, programIndex)
	}
	// swap
	tmeProgramIndex := programs[programIndexes[0]]
	programs[programIndexes[0]] = programs[programIndexes[1]]
	programs[programIndexes[1]] = tmeProgramIndex
}

func swapPartner(programs *[16]string, spinInstruction string) {
	lastPartOfInstruction := spinInstruction[1:]
	chunks := strings.Split(lastPartOfInstruction, "/")
	var indexOfFirst int
	var indexOfSecond int
	for i, program := range programs {
		if chunks[0] == program {
			indexOfFirst = i
		}
		if chunks[1] == program {
			indexOfSecond = i
		}
	}
	exchangeInstruction := fmt.Sprintf("e%d/%d", indexOfFirst, indexOfSecond)
	exchange(programs, exchangeInstruction)
}

func toString(arr [16]string) string {
	return strings.Join(arr[:], "")
}

func getFileData() []string {
	filename := os.Args[1]
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Split(line, ",")
		for _, part := range parts {
			filedata = append(filedata, part)
		}
	}
	return filedata
}

func createPrograms() [16]string {
	var programs [16]string
	var index int
	for i := 'a'; i <= 'p'; i++ {
		programs[index] = string(i)
		index++
	}
	return programs
}
