package main

import "testing"

func TestDag3_part1_1(t *testing.T) {

	Result := dag3_part1(1)
	Want := 0

	if Result != Want {
		t.Errorf("Wrong nr of steps. Got: %d, wanted: %d.", Result, Want)
	}
}

func TestDag3_part1_2(t *testing.T) {

	Result := dag3_part1(12)
	Want := 3

	if Result != Want {
		t.Errorf("Wrong nr of steps. Got: %d, wanted: %d.", Result, Want)
	}
}

func TestDag3_part1_3(t *testing.T) {

	Result := dag3_part1(23)
	Want := 2

	if Result != Want {
		t.Errorf("Wrong nr of steps. Got: %d, wanted: %d.", Result, Want)
	}
}

func TestDag3_part1_4(t *testing.T) {

	Result := dag3_part1(1024)
	Want := 31

	if Result != Want {
		t.Errorf("Wrong nr of steps. Got: %d, wanted: %d.", Result, Want)
	}
}
