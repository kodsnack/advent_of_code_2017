package day18

import (
	"strings"
	"strconv"
	"log"
	"sync"
)

func Part1(input string) int {
	registers := make(map[string]int)

	var lastPlayed int

	getValue := func(keyOrNum string) int {
		// check if number
		if n, err := strconv.Atoi(keyOrNum); err == nil {
			return n
		}

		// from registry
		if n, ok := registers[keyOrNum]; ok {
			return n
		}

		return 0
	}

	instructions := strings.Split(input, "\n")
	pos := 0

	for {
		if pos >= len(instructions) {
			log.Println("end of program")
			break
		}

		p := strings.Split(instructions[pos], " ")

		var jumped bool

		switch p[0] {
		case "snd":
			lastPlayed = getValue(p[1])
			break

		case "set":
			registers[p[1]] = getValue(p[2])
			break

		case "add":
			registers[p[1]] = getValue(p[1]) + getValue(p[2])
			break
		case "mul":
			registers[p[1]] = getValue(p[1]) * getValue(p[2])
			break
		case "mod":
			registers[p[1]] = getValue(p[1]) % getValue(p[2])
			break

		case "rcv":
			if getValue(p[1]) != 0 {
				return lastPlayed
			}
			break

		case "jgz":
			if getValue(p[1]) > 0 {
				pos += getValue(p[2])
				jumped = true
				break
			}
		}

		if !jumped {
			pos++
		}
	}

	return -1
}

func Part2(input string) int {
	from0to1 := make(chan int, 1000)
	from1to0 := make(chan int, 1000)

	sendCounter0 := 0
	sendCounter1 := 0

	mx := &sync.Mutex{}
	currentReadCounter := 0

	wg := &sync.WaitGroup{}

	wg.Add(1)
	wg.Add(1)

	go part2Program(input, 0, from1to0, from0to1, &sendCounter0, mx, &currentReadCounter, wg)
	go part2Program(input, 1, from0to1, from1to0, &sendCounter1, mx, &currentReadCounter, wg)

	wg.Wait()

	return sendCounter1
}

func part2Program(input string, programNum int, inputChan <-chan int, outputChan chan<- int, sendCounter *int, mx *sync.Mutex, currentReadCounter *int, wg *sync.WaitGroup) {
	defer wg.Done()

	registers := make(map[string]int)
	registers["p"] = programNum

	getValue := func(keyOrNum string) int {
		// check if number
		if n, err := strconv.Atoi(keyOrNum); err == nil {
			return n
		}

		// from registry
		if n, ok := registers[keyOrNum]; ok {
			return n
		}

		return 0
	}

	instructions := strings.Split(input, "\n")
	pos := 0

	for {
		if pos >= len(instructions) {
			log.Println("end of program")
			break
		}

		p := strings.Split(instructions[pos], " ")

		var jumped bool

		switch p[0] {
		case "snd":
			outputChan <- getValue(p[1])
			*sendCounter++
			break

		case "set":
			registers[p[1]] = getValue(p[2])
			break

		case "add":
			registers[p[1]] = getValue(p[1]) + getValue(p[2])
			break
		case "mul":
			registers[p[1]] = getValue(p[1]) * getValue(p[2])
			break
		case "mod":
			registers[p[1]] = getValue(p[1]) % getValue(p[2])
			break

		case "rcv":
			mx.Lock()
			*currentReadCounter++
			if *currentReadCounter == 2 && len(inputChan) == 0 {
				outputChan <- -102312312383 // magic constant
				mx.Unlock()
				return
			}
			mx.Unlock()

			inp := <-inputChan
			if inp == -102312312383 {
				return
			}

			registers[p[1]] = inp

			mx.Lock()
			*currentReadCounter--
			mx.Unlock()

			break

		case "jgz":
			if getValue(p[1]) > 0 {
				pos += getValue(p[2])
				jumped = true
				break
			}
		}

		if !jumped {
			pos++
		}
	}
}
