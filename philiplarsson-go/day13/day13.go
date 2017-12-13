package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
	"time"
)

type firewall struct {
	depth      int
	scannerPos int
	direction  int
	width      int // can't use range (protected keyword)
}

type position struct {
	direction  int
	scannerPos int
}

var delayPosition map[int]map[int]position

func init() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide filename as argument to this program. ")
		fmt.Println(" Example: go run day13.go puzzle.in")
		os.Exit(1)
	}
	delayPosition = make(map[int]map[int]position)
}

func main() {
	filedata := readFileData()
	firewalls := createFirewalls(filedata)
	part1(firewalls)
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

func part1(firewalls map[int]*firewall) {
	lastFirewall := getLastFirewall(firewalls)
	maxLayer := lastFirewall.depth
	var severity int
	for layer := 0; layer <= maxLayer; layer++ {
		fw, ok := firewalls[layer]
		if ok {
			if fw.scannerPos == 0 {
				severity += fw.depth * fw.width
			}
		}
		moveFirewallScanners(firewalls)
	}
	fmt.Println("Part 1")
	fmt.Println(" The severity of the trip was:", severity)
}

func part2(filedata []string) {
	fmt.Println("Part 2")
	caught := true
	var sleepTime int
	originalFirewalls := createFirewalls(filedata)
	lastFirewall := getLastFirewall(originalFirewalls)
	maxLayer := lastFirewall.depth
	startTime := time.Now()
	var printCounter int

	for caught == true {
		// Print so we see that something is happening
		if printCounter <= sleepTime {
			diff := time.Now().Sub(startTime)
			fmt.Printf(" Sleeptime is %d \t(%f)\n", sleepTime, diff.Seconds())
			printCounter = sleepTime * 10
		}
		caught = false
		firewalls := copyMap(originalFirewalls)

		sleepUpTill(sleepTime, firewalls)

		for layer := 0; layer <= maxLayer; layer++ {
			fw, ok := firewalls[layer]
			if ok {
				if fw.scannerPos == 0 {
					caught = true
					break
				}
			}
			moveFirewallScanners(firewalls)
		}
		sleepTime++
	}
	timeDiffEnd := time.Now().Sub(startTime)
	fmt.Printf(" Part 2 took %f seconds to solve.\n\n", timeDiffEnd.Seconds())
	fmt.Println(" Number of picoseconds that need to be delayed is:", sleepTime-1)
}

func createFirewalls(data []string) map[int]*firewall {
	firewalls := make(map[int]*firewall, 0)
	for _, line := range data {
		chunks := strings.Fields(line)
		chunkUno := strings.TrimSuffix(chunks[0], ":")
		chunkDos := chunks[1]

		depth, err := strconv.Atoi(chunkUno)
		if err != nil {
			log.Fatal(err)
		}
		width, err := strconv.Atoi(chunkDos)
		if err != nil {
			log.Fatal(err)
		}

		firewall := firewall{
			depth:     depth,
			width:     width,
			direction: 1,
		}
		firewalls[depth] = &firewall
	}

	return firewalls
}

func moveFirewallScanners(firewalls map[int]*firewall) {
	for _, fw := range firewalls {
		fw.step()
	}
}

func (fw *firewall) step() {
	// Make sure we don't go above or below range (width)
	if fw.scannerPos == (fw.width - 1) {
		fw.direction = -1
	} else if fw.scannerPos == 0 {
		fw.direction = 1
	}
	fw.scannerPos += fw.direction
}

func getLastFirewall(firewalls map[int]*firewall) firewall {
	var maxDepth int
	for k, _ := range firewalls {
		if k > maxDepth {
			maxDepth = k
		}
	}
	return *firewalls[maxDepth]
}

func copyMap(original map[int]*firewall) map[int]*firewall {
	newMap := make(map[int]*firewall)
	for depth, fw := range original {
		newFirewall := firewall{
			depth:      fw.depth,
			width:      fw.width,
			direction:  fw.direction,
			scannerPos: fw.scannerPos,
		}
		newMap[depth] = &newFirewall
	}
	return newMap
}

// Since it takes too long time calculating steps for each sleepTime
// we cache these in a map (delayPosition).
func sleepUpTill(sleepTime int, firewalls map[int]*firewall) {
	depthMap, exists := delayPosition[sleepTime-1]
	if exists {
		// Change position on all firewalls at that delay in time
		for _, firewall := range firewalls {
			firewall.scannerPos = depthMap[firewall.depth].scannerPos
			firewall.direction = depthMap[firewall.depth].direction
		}
		// move one
		moveFirewallScanners(firewalls)
		// update delayPosition with new step
		newDepthMap := make(map[int]position)
		for depth, firewall := range firewalls {
			newPosition := position{
				scannerPos: firewall.scannerPos,
				direction:  firewall.direction,
			}
			newDepthMap[depth] = newPosition
		}
		// update delayPosition[sleepTime]
		delayPosition[sleepTime] = newDepthMap
	} else {
		// we don't have that index yet. Create it
		newDepthMap := make(map[int]position)
		for depth, firewall := range firewalls {
			newPosition := position{
				scannerPos: firewall.scannerPos,
				direction:  firewall.direction,
			}
			newDepthMap[depth] = newPosition
		}
		// update delayPosition[sleepTime]
		delayPosition[sleepTime] = newDepthMap
	}
}
