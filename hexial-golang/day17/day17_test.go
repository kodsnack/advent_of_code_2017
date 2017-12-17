package day17

import (
	"AdventOfCode2017/util"
	"testing"
)

func Test(t *testing.T) {

	//d := NewDance("sample", 5)
	//d.Move("s1")
	//d.State()
	//NewCircularBuffer(3, 9)
	util.AssertEqual(t, 638, NewCircularBuffer(3, 2017).NextVal())
	util.AssertEqual(t, 204, NewCircularBuffer(380, 2017).NextVal())
	util.AssertEqual(t, 28954211, NewCircularBuffer(380, 50000000).ValPos1())

}
