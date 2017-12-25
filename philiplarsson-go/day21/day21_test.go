package main

import (
	"testing"
)

// Layout of tests comes from ch 9 in the book "Go in Action" by William Kennedy et al.
// Run with "go test -v" to see verbose output.

const checkMark = "\u2713"
const ballotX = "\u2717"

func TestCreate3x3Rule(t *testing.T) {
	inputLine := ".../.../... => #.#./#..#/#.##/#.#."
	t.Log("Given the need to test creating 3x3 rule")
	{
		t.Logf("\tWhen creating rule with input %s", inputLine)
		{
			rule := create3x3Rule(inputLine)

			lenInput := 3
			if len(rule.inputPattern) == lenInput {
				t.Logf("\t\tShould have a length of %d as inputPattern. %v", lenInput, checkMark)
			} else {
				t.Errorf("\t\tShould recieve length of %d, got %d. %v", lenInput, len(rule.inputPattern), ballotX)
			}

			lenOutput := 4
			if len(rule.outputPattern) == lenOutput {
				t.Logf("\t\tShould have a length of %d as outputPattern. %v", lenOutput, checkMark)
			} else {
				t.Errorf("\t\tShould recieve length of %d, got %d. %v", lenOutput, len(rule.outputPattern), ballotX)
			}

			expectedOutput := [4][4]string{
				{"#", ".", "#", "."},
				{"#", ".", ".", "#"},
				{"#", ".", "#", "#"},
				{"#", ".", "#", "."},
			}
			if rule.outputPattern == expectedOutput {
				t.Logf("\t\tShould have an output that looks like \"%s\". %v", expectedOutput, checkMark)
			} else {
				t.Errorf("\t\tShould have an output that looks like \"%s\", got \"%s\". %v", expectedOutput, rule.outputPattern, ballotX)
			}
		}

	}
}

func TestFlip3x3Rule(t *testing.T) {
	inputLine := "#../#.#/##. => .#.#/####/###./...."
	t.Log("Given the need to test flipping a 3x3 rule")
	{
		t.Logf("\tWhen creating rule with input \"%s\" and rotating once", inputLine)
		{
			rule := create3x3Rule(inputLine)

			flippedRule := createFlipped3x3Rule(rule)

			expectedInput := [3][3]string{
				{".", ".", "#"},
				{"#", ".", "#"},
				{".", "#", "#"},
			}

			if flippedRule.inputPattern == expectedInput {
				t.Logf("\t\tShould have an input row that looks like \"%s\". %v", expectedInput, checkMark)
			} else {
				t.Errorf("\t\tShould have an input row that looks like \"%s\", got \"%s\". %v", expectedInput, flippedRule.inputPattern, ballotX)
			}
		}
	}
}

func TestRotate3x3Rule(t *testing.T) {
	inputLine := ".#./..#/### => .#.#/####/###./...."
	t.Log("Given the need to test rotating a 3x3 rule")
	{
		t.Logf("\tWhen creating rule with input \"%s\" and rotating once", inputLine)
		{
			rule := create3x3Rule(inputLine)

			firstRotatedRule := createRotated3x3Rule(rule)

			expectedInput := [3][3]string{
				{"#", ".", "."},
				{"#", ".", "#"},
				{"#", "#", "."},
			}

			if firstRotatedRule.inputPattern == expectedInput {
				t.Logf("\t\tShould have an input that looks like \"%s\". %v", expectedInput, checkMark)
			} else {
				t.Errorf("\t\tShould have an input that looks like \"%s\", got \"%s\". %v", expectedInput, firstRotatedRule.outputPattern, ballotX)
			}

		}
		t.Logf("\tWhen creating rule with input \"%s\" and rotating twice", inputLine)
		{
			rule := create3x3Rule(inputLine)
			secondRotatedRule := createRotated3x3Rule(createRotated3x3Rule(rule))

			expectedInput := [3][3]string{
				{"#", "#", "#"},
				{"#", ".", "."},
				{".", "#", "."},
			}

			if secondRotatedRule.inputPattern == expectedInput {
				t.Logf("\t\tShould have an input that looks like \"%s\". %v", expectedInput, checkMark)
			} else {
				t.Errorf("\t\tShould have an input that looks like \"%s\", got \"%s\". %v", expectedInput, secondRotatedRule.outputPattern, ballotX)
			}
		}
	}
}
