package main

import "testing"

func Test_Ex1(t *testing.T) {
	str := "1122"
	if calcSum(str) != 3 {
		t.Error()
	}
}

func Test_Ex2(t *testing.T) {
	str := "1111"
	if calcSum(str) != 4 {
		t.Error()
	}
}

func Test_Ex3(t *testing.T) {
	str := "1234"
	if calcSum(str) != 0 {
		t.Error()
	}
}

func Test_Ex4(t *testing.T) {
	str := "91212129"
	if calcSum(str) != 9 {
		t.Error()
	}
}

func Test_Ex5(t *testing.T) {
	str := "1212"
	if calcSum2(str) != 6 {
		t.Error()
	}
}

func Test_Ex6(t *testing.T) {
	str := "1221"
	if calcSum2(str) != 0 {
		t.Error()
	}
}

func Test_Ex7(t *testing.T) {
	str := "123425"
	if calcSum2(str) != 4 {
		t.Error()
	}
}

func Test_Ex8(t *testing.T) {
	str := "123123"
	if calcSum2(str) != 12 {
		t.Error()
	}
}

func Test_Ex9(t *testing.T) {
	str := "12131415"
	if calcSum2(str) != 4 {
		t.Error()
	}
}
