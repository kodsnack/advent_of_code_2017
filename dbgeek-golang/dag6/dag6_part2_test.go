package main

import "testing"

func TestDag6_part2_1(t *testing.T) {

	want := 4
	got := SolveDag6_part2([]int{2, 4, 1, 2})

	if want != got {
		t.Errorf("got: %d, want: %d.\n", got, want)
	}
}

func TestDag6_part2_2(t *testing.T) {

	want := 1610

	got := SolveDag6_part2([]int{2, 8, 8, 5, 4, 2, 3, 1, 5, 5, 1, 2, 15, 13, 5, 14})

	if want != got {
		t.Errorf("got: %d, want: %d.\n", got, want)
	}
}
