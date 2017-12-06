package main

import "testing"

func TestDag6_part1(t *testing.T) {

	want := 5
	got := SolveDag6([]int{0, 2, 7, 0})

	if want != got {
		t.Errorf("got: %d, want: %d.\n", got, want)
	}
}

func TestDag6_part2(t *testing.T) {

	want := 3156
	got := SolveDag6([]int{2, 8, 8, 5, 4, 2, 3, 1, 5, 5, 1, 2, 15, 13, 5, 14})

	if want != got {
		t.Errorf("got: %d, want: %d.\n", got, want)
	}
}
