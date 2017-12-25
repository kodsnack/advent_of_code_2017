package day13

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOneAndTwo(t *testing.T) {
	util.AssertEqual(t, 1, Steps(1))
	util.AssertEqual(t, 3, Steps(2))
	util.AssertEqual(t, 5, Steps(3))
	util.AssertEqual(t, 7, Steps(4))

	for i := 0; i < 9; i++ {
		if i == 0 || i == 4 || i == 8 {
			util.AssertEqual(t, true, TestHit(3, i, 0))
		} else {
			util.AssertEqual(t, false, TestHit(3, i, 0))
		}
	}

	util.AssertEqual(t, 24, NewFirewall("sample").Severity())
	util.AssertEqual(t, 2160, NewFirewall("input").Severity())
	//util.LogInfof("*********************'")
	util.AssertEqual(t, 10, NewFirewall("sample").Delay())
	util.LogInfof("My answer: %d", NewFirewall("input").Delay())
}
