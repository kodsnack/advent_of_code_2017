package day16

import (
	"AdventOfCode2017/util"
	"fmt"
	"strconv"
	"strings"
)

func Fix(loops int, repeat int) int {
	return loops - ((loops / repeat) * repeat)
}

const (
	S = iota
	X = iota
	P = iota
)

type Move struct {
	T      int
	S_SIZE int
	X_A    int
	X_B    int
	P_A    rune
	P_B    rune
}

type Dance struct {
	programs []rune
	original string
	moves    []Move
	size     int
}

func NewDance(filename string, size int) *Dance {
	d := new(Dance)
	d.size = size
	d.Compile(filename)
	d.Setup()
	d.original = d.AsString()
	return d
}

func (d *Dance) Setup() {
	d.programs = make([]rune, d.size)
	for i := 0; i < d.size; i++ {
		d.programs[i] = rune('a' + i)
	}
}

func (d *Dance) Compile(filename string) {
	var err error
	for _, m := range util.FileAsWordArraySep(filename, ",")[0] {
		move := Move{}
		if strings.HasPrefix(m, "s") {
			move.T = S
			move.S_SIZE, err = strconv.Atoi(m[1:])
			if err != nil {
				util.LogPanicf("%s - %v", m, err)
			}
		} else if strings.HasPrefix(m, "x") {
			move.T = X
			move.X_A, err = strconv.Atoi(strings.Split(m[1:], "/")[0])
			if err != nil {
				panic(err)
			}
			move.X_B, err = strconv.Atoi(strings.Split(m[1:], "/")[1])
			if err != nil {
				panic(err)
			}
		} else if strings.HasPrefix(m, "p") {
			move.T = P
			move.P_A = []rune(m)[1]
			move.P_B = []rune(m)[3]
		} else {
			panic(m)
		}
		d.moves = append(d.moves, move)
	}

}

func (d *Dance) State() {
	util.LogInfof("%s", d.AsString())
}

func (d *Dance) AsString() string {
	s := ""
	for i := 0; i < len(d.programs); i++ {
		s += fmt.Sprintf("%c", d.programs[i])
	}
	return s
}

func (d *Dance) ExecutePartOne() string {
	for j := range d.moves {
		d.Move(j)
		//d.State()
	}
	return d.AsString()
}

func (d *Dance) ExecutePartTwo() string {
	loops := 1000000000
	var repeat int
	var i int
	for repeat == 0 {
		i++
		for j := range d.moves {
			d.Move(j)
		}
		if d.original == d.AsString() {
			repeat = i
		}
	}
	util.LogInfof("Matches: %d", repeat)
	util.LogInfof("Should run: %d", Fix(loops, repeat))
	d.Setup()
	for i := 0; i < Fix(loops, repeat); i++ {
		for j := range d.moves {
			d.Move(j)
		}
	}
	return d.AsString()
}

func (d *Dance) Move(j int) {
	if d.moves[j].T == S {
		d.programs = append(d.programs[len(d.programs)-d.moves[j].S_SIZE:], d.programs[0:len(d.programs)-d.moves[j].S_SIZE]...)
	} else if d.moves[j].T == X {
		d.programs[d.moves[j].X_A], d.programs[d.moves[j].X_B] = d.programs[d.moves[j].X_B], d.programs[d.moves[j].X_A]
	} else if d.moves[j].T == P {
		i1 := -1
		i2 := -1
		// Find p1/p2
		for i := 0; i < len(d.programs); i++ {
			if d.programs[i] == d.moves[j].P_A {
				i1 = i
			}
			if d.programs[i] == d.moves[j].P_B {
				i2 = i
			}
		}
		d.programs[i1], d.programs[i2] = d.moves[j].P_B, d.moves[j].P_A
	} else {
		panic(d.moves[j])
	}
}
