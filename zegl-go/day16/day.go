package day16

import (
	"strings"
	"strconv"
)

func Part1(input string) string {
	return prettify(dance(startPosition(), parse(input)))
}

func Part2(input string) string {
	moves := parse(input)
	dancers := startPosition()
	originalPosition := prettify(startPosition())

	repetition := 0
	for i := 0; i < 1000000000; i++ {
		dancers = dance(dancers, moves)
		if prettify(dancers) == originalPosition {
			repetition = i + 1
			break
		}
	}

	i := 0
	for {
		i += repetition
		if i > 1000000000 {
			i -= repetition
			break
		}
	}

	dancers = startPosition()
	for ii := i; ii < 1000000000; ii++ {
		dancers = dance(dancers, moves)
	}

	return prettify(dancers)
}

func prettify(input [16]uint8) string {
	var chars []string
	for _, v := range input {
		chars = append(chars, string(v))
	}
	return strings.Join(chars, "")
}

func startPosition() [16]uint8 {
	var dancers [16]uint8
	char := uint8('a')
	for i := uint8(0); i < 16; i++ {
		dancers[i] = char + i
	}
	return dancers
}

type moveType uint8

const (
	moveSpin     moveType = iota
	moveExchange
	movePartner
)

type move struct {
	t        moveType
	arg1     int
	arg2     int
	arg1char uint8
	arg2char uint8
}

func parse(input string) []move {
	var moves []move

	for _, cmd := range strings.Split(input, ",") {
		switch cmd[0] {
		case 's':
			n, err := strconv.Atoi(cmd[1:])
			if err != nil {
				panic(err)
			}
			moves = append(moves, move{
				t:    moveSpin,
				arg1: n,
			})
		case 'x':
			s := strings.Split(cmd[1:], "/")
			a, err := strconv.Atoi(s[0])
			if err != nil {
				panic(err)
			}
			b, err := strconv.Atoi(s[1])
			if err != nil {
				panic(err)
			}
			moves = append(moves, move{
				t:    moveExchange,
				arg1: a,
				arg2: b,
			})
		case 'p':
			s := strings.Split(cmd[1:], "/")
			moves = append(moves, move{
				t:        movePartner,
				arg1char: s[0][0],
				arg2char: s[1][0],
			})
		}
	}

	return moves
}

var t uint8
var keyA int
var keyB int

func dance(dancers [16]uint8, moves []move) [16]uint8 {
	for _, m := range moves {
		switch m.t {
		case moveSpin:
			var n [16]uint8
			for i := 0; i < m.arg1; i++ {
				n[i] = dancers[16-m.arg1+i]
			}
			for i := 0; i < 16-m.arg1; i++ {
				n[m.arg1+i] = dancers[i]
			}
			dancers = n

		case moveExchange:
			t = dancers[m.arg2]
			dancers[m.arg2] = dancers[m.arg1]
			dancers[m.arg1] = t

		case movePartner:
			for k, d := range dancers {
				if d == m.arg1char {
					keyA = k
				}
				if d == m.arg2char {
					keyB = k
				}
			}
			dancers[keyA] = m.arg2char
			dancers[keyB] = m.arg1char
		}
	}

	return dancers
}
