package main

import "testing"

func TestDaySumSlice(t *testing.T) {
	Result := SumSlice([]int{1, 2, 3, 4, 5, 6, 7, 8, 9})
	Want := 45
	if Result != Want {
		t.Errorf("Result was wrong, got: %d, want: %d.", Result, Want)

	}
}

func TestGetDiffFromSlice(t *testing.T) {

	Result := GetDiffFromSlice([]string{"5", "1", "9", "5"})
	Want := 8
	if Result != Want {
		t.Errorf("Result was wrong, got: %d, want: %d.", Result, Want)

	}
}
