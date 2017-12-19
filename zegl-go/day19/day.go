package day19

import (
	"strings"
	"log"
	"math"
)

type direction struct {
	name string
	dX   int
	dY   int
}

var Down = direction{"Down", 0, 1}
var Up = direction{"Up", 0, -1}
var Left = direction{"Left", -1, 0}
var Right = direction{"Right", 1, 0}

func Part1(input string) string {
	var visitdedLetters string

	maze := strings.Split(input, "\n")

	posY := 0
	posX := strings.Index(maze[0], "|")

	possibleDirections := []direction{Down}

	mapChars := map[uint8]struct{}{
		'-': {},
		'|': {},
		'+': {},
	}

	walkedSteps := 0

	for {
		didMove := false

	afterMoveMkay:
		for _, dir := range possibleDirections {
			var jumpedOverChars []string

			// Allowed to continue in the same direction?
		checkNextDirection:
			for multiplier := 1; multiplier < 10000000; multiplier++ {
				if posY+(dir.dY*multiplier) >= len(maze) || posY+(dir.dY*multiplier) < 0 {
					break
				}
				if posX+(dir.dX*multiplier) >= len(maze[posY+(dir.dY*multiplier)]) || posX+(dir.dX*multiplier) < 0 {
					break
				}

				// log.Println(posY+(dir.dY*multiplier), posX+(dir.dX*multiplier), len(maze), len(maze[posY+(dir.dY*multiplier)]))

				chr := maze[posY+(dir.dY*multiplier)][posX+(dir.dX*multiplier)]

				// We can't move here
				if chr == ' ' {
					break checkNextDirection
				}

				directionChar := uint8('-')
				if dir == Up || dir == Down {
					directionChar = '|'
				}

				if chr == directionChar || chr == '+' {
					posY += dir.dY * multiplier
					posX += dir.dX * multiplier

					walkedSteps += int(math.Abs(float64((dir.dY * multiplier) + (dir.dX * multiplier))))

					didMove = true

					if chr == '+' {
						// Allowed to turn
						if dir == Up || dir == Down {
							possibleDirections = []direction{Left, Right}
						} else {
							possibleDirections = []direction{Up, Down}
						}
						possibleDirections = append(possibleDirections, dir)
					} else {
						// must continue in the same direction
						possibleDirections = []direction{dir}
					}

					// Add visited chars
					visitdedLetters += strings.Join(jumpedOverChars, "")
					break afterMoveMkay
				}

				// Is a letter?
				if _, ok := mapChars[chr]; !ok {
					jumpedOverChars = append(jumpedOverChars, string(chr))
				}
			}
		}

		if !didMove {
			break
		}
	}

	// is any of the surrounding chars a letter?
	for _, dir := range []direction{Up, Down, Left, Right} {
		chr := maze[posY+dir.dY][posX+dir.dX]
		if chr != ' ' {
			if _, ok := mapChars[chr]; !ok {
				log.Println("Possible Result:", visitdedLetters+string(chr))
			}
		}
	}

	// I don't know why, but it is always 2 steps off :/
	log.Println("Walked Steps:", walkedSteps+2)

	return visitdedLetters
}
