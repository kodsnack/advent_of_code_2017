package main

import (
	"testing"
)

// func TestMain(m *testing.M) {
// 	oldArgs := os.Args
// 	defer func() { os.Args = oldArgs }()
// 	os.Args = []string{"cmd", "65", "8921"}
// 	os.Exit(m.Run())
// }

func TestToBinary(t *testing.T) {
	tables := []struct {
		value    int
		expected string
	}{
		{1092455, "00000000000100001010101101100111"},
		{430625591, "00011001101010101101001100110111"},
		{54, "00000000000000000000000000110110"},
	}
	for _, table := range tables {
		strValue := toBinary(table.value)
		if strValue != table.expected {
			t.Errorf("toBinary was incorrect, input %d got\n %s. Want\n %s", table.value, strValue, table.expected)
		}
	}
}

func TestLast16(t *testing.T) {
	tables := []struct {
		value    string
		expected string
	}{
		{"00000000000100001010101101100111", "1010101101100111"},
		{"00001110101000101110001101001010", "1110001101001010"},
	}
	for _, table := range tables {
		realValue := last16(table.value)
		if realValue != table.expected {
			t.Errorf("last16 was incorrect. Input %s\n Got \t%s \n Want \t%s", table.value, realValue, table.expected)
		}
		if len(realValue) != 16 {
			t.Error("last16 was incorrect. Didn't get a string of length 16")
		}
	}
}
