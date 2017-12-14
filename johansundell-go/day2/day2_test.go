package main

import "testing"

func Test_Ex1(t *testing.T) {
	str := `5	1	9	5
7	5	3
2	4	6	8`
	if sum, _ := getChecksum(str); sum != 18 {
		t.Error()
	}
}

func Test_Ex2(t *testing.T) {
	str := `5	9	2	8
9	4	7	3
3	8	6	5`
	if _, sum := getChecksum(str); sum != 9 {
		t.Error()
	}
}
