package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

//////////////////////////////
////////// Typedefs //////////
//////////////////////////////

const startGroup = '{'
const endGroup = '}'
const startGarbage = '<'
const endGarbage = '>'
const escape = '!'

const debug = true

/////////////////////////////
////////// Globals //////////
//////////////////////////////

var stream string
var normalMode = true
var escapeMode = false
var level = 0

///////////////////////////////
////////// Functions //////////
///////////////////////////////

func readStreamFromFile(f string) string {
	file, err := os.Open(f)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	reader := bufio.NewReader(file)
	// Read all bytes to buffer
	stream, _ := reader.ReadString(0x00)
	return stream
}

func checkStream(s string) (score int, garbage int) {

	groups := 0
	chars := 0

	score = 0
	garbage = 0

	for _, x := range s {
		if debug {
			fmt.Printf("Considering character %d (%c)\n", chars, x)
		}
		chars++
		if normalMode { // Normal mode
			switch x {
			case startGroup:
				level++
				groups++
				score += level
				if debug {
					fmt.Printf("  It's a startGroup, so level is now %d and score increased to %d\n", level, score)
				}
			case endGroup:
				level--
				if debug {
					fmt.Printf("  It's a endGroup, so level is now %d\n", level)
				}
			case startGarbage:
				normalMode = false
				if debug {
					fmt.Printf("  It's a garbage marker, so switching to garbage mode\n")
				}
			default:
				if debug {
					fmt.Printf("  It's nothing special\n")
				}
				continue
			}
		} else { // Garbage mode
			switch x {
			case escape:
				if !escapeMode {
					if debug {
						fmt.Printf("  It's an escape so will disregard next character\n")
					}
					escapeMode = true
				} else {
					if debug {
						fmt.Printf("  It's an escape but I'm in escape mode so it doesn't matter\n")
					}
					escapeMode = false
					continue
				}
			case endGarbage:
				if !escapeMode {
					if debug {
						fmt.Printf("  It's an endGarbage so will switch to normal mode\n")
					}
					normalMode = true
					escapeMode = false
				} else {
					if debug {
						fmt.Printf("  It's an endGarbage but I'm in escape mode so it doesn't matter\n")
					}
					escapeMode = false
					continue
				}
			default:
				if escapeMode {
					if debug {
						fmt.Printf("  It's nothing special but I'm in escape mode so it doesn't matter\n")
					}
				} else {
					garbage++
					if debug {
						fmt.Printf("  It's nothing special (since I'm in garbage mode) so I'll one more garbage thrown away making the total %d\n", garbage)
					}
				}
				escapeMode = false
			}
		}
	}
	return
}

func main() {

	stream := readStreamFromFile("input.txt")

	// Test streams
	//stream = "{}" // score of 1.
	//stream = "{{{}}}" // score of 1 + 2 + 3 = 6.
	//stream = "{{},{}}" // score of 1 + 2 + 2 = 5.
	//stream = "{{{},{},{{}}}}" // score of 1 + 2 + 3 + 3 + 3 + 4 = 16.
	//stream = "{<a>,<a>,<a>,<a>}" // score of 1.
	//stream = "{{<ab>},{<ab>},{<ab>},{<ab>}}" // score of 1 + 2 + 2 + 2 + 2 = 9.
	//stream = "{{<!!>},{<!!>},{<!!>},{<!!>}}" // score of 1 + 2 + 2 + 2 + 2 = 9.
	//stream = "{{<a!>},{<a!>},{<a!>},{<ab>}}" //score of 1 + 2 = 3.

	//stream = "<>" // 0 characters.
	//stream = "<random characters>" // 17 characters.
	//stream = "<<<<>" // 3 characters.
	//stream = "<{!>}>" // 2 characters.
	//stream = "<!!>" // 0 characters.
	//stream = "<!!!>>" // 0 characters.
	//stream = "<{o\"i!a,<{i<a>" // 10 characters.

	score, garbage := checkStream(stream)

	fmt.Println("Ended processing with score", score, "and", garbage, "pieces of garbage removed")
}
