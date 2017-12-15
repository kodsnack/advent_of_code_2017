package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"time"
)

var generatorAStartValue int
var generatorBStartValue int

func setupArgs() {
	if len(os.Args) != 3 {
		fmt.Println("Enter start values for the generators as arguments.")
		fmt.Println(" Example: go run day15.go 65 8921")
		os.Exit(1)
	}
	argUno, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Println("Please provide two numbers. ")
		log.Fatal(err)
	}
	argDos, err := strconv.Atoi(os.Args[2])
	if err != nil {
		fmt.Println("Please provide two numbers. ")
		log.Fatal(err)
	}
	generatorAStartValue = argUno
	generatorBStartValue = argDos
}

func main() {
	setupArgs()
	fmt.Println("Using", generatorAStartValue, "as start value for A.")
	fmt.Println("Using", generatorBStartValue, "as start value for B.")

	part1()
	part2()
}

func part1() {
	fmt.Println("Part 1")
	generatorAValue := generatorAStartValue
	generatorBValue := generatorBStartValue
	matches := 0
	fourtyMillion := int(40 * math.Pow(10, 6))
	for i := 0; i < fourtyMillion; i++ {
		generatorAValue = generateValue(generatorAValue, 16807)
		generatorBValue = generateValue(generatorBValue, 48271)

		aInBinary := toBinary(generatorAValue)
		bInBinary := toBinary(generatorBValue)
		if last16(aInBinary) == last16(bInBinary) {
			matches++
		}
	}

	fmt.Printf(" Got %d matches.\n", matches)
}

func part2() {
	fmt.Println("Part 2")
	chA := make(chan string, 50)
	chB := make(chan string, 50)
	result := make(chan int)

	startTime := time.Now()
	go calculateValues(chA, 4, generatorAStartValue, 16807)
	go calculateValues(chB, 8, generatorBStartValue, 48271)
	go compareValues(result, chA, chB)

	fmt.Println("  Started goroutines. Waiting for result. ")
	finalCount := <-result
	fmt.Println("  Done. ")
	totalTime := time.Now().Sub(startTime)

	fmt.Printf(" Final count is %d (part 2 took %.2f seconds).\n", finalCount, totalTime.Seconds())
}

func calculateValues(ch chan string, divisor int, startValue int, factor int) {
	generatorValue := startValue
	fiveMillion := int(5 * math.Pow(10, 6))
	pairs := 0
	for pairs < fiveMillion {
		generatorValue = generateValue(generatorValue, factor)
		if generatorValue%divisor == 0 {
			valueInBinary := toBinary(generatorValue)
			ch <- valueInBinary
			pairs++
		}
	}
	close(ch)
}

// compareValues is the judge that compares if both values has the same
// last 16 bits.
func compareValues(result chan int, chA chan string, chB chan string) {
	var count int
	for {
		// Fetch result from A
		aInBinary, more := <-chA
		if !more {
			result <- count
			return
		}
		// Fetch result from B
		bInBinary, more := <-chB
		if !more {
			result <- count
			return
		}
		if last16(aInBinary) == last16(bInBinary) {
			count++
		}
	}
}

// toBinary returns the binary value of a input-value in base 10 as a string.
// If the binary value isn't 32 bit long it precedes the string with zeroes.
func toBinary(input int) string {
	return fmt.Sprintf("%032b", input)
}

func last16(input string) string {
	return input[len(input)-16:]
}

func generateValue(value int, factor int) int {
	dividor := 2147483647
	return (value * factor) % dividor
}
