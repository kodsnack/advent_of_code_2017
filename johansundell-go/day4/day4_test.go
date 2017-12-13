package main

import "testing"

func Test_Ex1(t *testing.T) {
	str := "aa bb cc dd ee"
	if !isValid(str, false) {
		t.Error()
	}
}

func Test_Ex2(t *testing.T) {
	str := "aa bb cc dd aa"
	if isValid(str, false) {
		t.Error()
	}
}

func Test_Ex3(t *testing.T) {
	str := "aa bb cc dd aaa"
	if !isValid(str, false) {
		t.Error()
	}
}

func Test_Ex4(t *testing.T) {
	str := "abcde fghij"
	if !isValid(str, true) {
		t.Error()
	}
}

func Test_Ex5(t *testing.T) {
	str := "abcde xyz ecdab"
	if isValid(str, true) {
		t.Error()
	}
}

func Test_Ex6(t *testing.T) {
	str := "a ab abc abd abf abj"
	if !isValid(str, true) {
		t.Error()
	}
}

func Test_Ex7(t *testing.T) {
	str := "iiii oiii ooii oooi oooo"
	if !isValid(str, true) {
		t.Error()
	}
}

func Test_Ex8(t *testing.T) {
	str := "oiii ioii iioi iiio"
	if isValid(str, true) {
		t.Error()
	}
}
