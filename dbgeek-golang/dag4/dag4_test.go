package main

import "testing"

func TestDag4_ContainString(t *testing.T) {

	s := []string{"AA", "BB", "CC", "DD", "aa", "bB"}

	if !containString(s, "bb") {
		t.Errorf("Function does not find bb in slice")
	}
}
