package main

import "testing"

func TestDayOne1(t *testing.T) {

	Result := DayOne([]string{"1", "1", "2", "2"})
	Want := 3
	if Result != Want {
		t.Errorf("Result was wrong, got: %d, want: %d.", Result, Want)

	}
}

func TestDayOne2(t *testing.T) {

	Result := DayOne([]string{"1", "1", "1", "1"})
	Want := 4
	if Result != Want {
		t.Errorf("Result was wrong, got: %d, want: %d.", Result, Want)

	}

}

func TestDayOne3(t *testing.T) {

	Result := DayOne([]string{"1", "2", "3", "4"})
	Want := 0
	if Result != Want {
		t.Errorf("Result was wrong, got: %d, want: %d.", Result, Want)

	}

}

func TestDayOne4(t *testing.T) {

	Result := DayOne([]string{"9", "1", "2", "1", "2", "1", "2", "9"})
	Want := 9
	if Result != Want {
		t.Errorf("Result was wrong, got: %d, want: %d.", Result, Want)

	}

}
