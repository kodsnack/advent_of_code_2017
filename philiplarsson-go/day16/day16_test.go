package main

import (
	"testing"
)

func TestSpin(t *testing.T) {

	tables := []struct {
		input    string
		expected string
	}{
		{"s1", "pabcdefghijklmno"},
		{"s3", "nopabcdefghijklm"},
	}
	for _, table := range tables {
		programs := createPrograms()
		spin(&programs, table.input)
		if toString(programs) != table.expected {
			t.Errorf("testSpin was incorrect. Input %s \nGot\n %s\nWant\n %s", table.input, toString(programs), table.expected)
		}
	}
}

func TestToString(t *testing.T) {
	programs := createPrograms()
	asString := toString(programs)
	if asString != "abcdefghijklmnop" {
		t.Error("toString was incorrect.")
	}
}
