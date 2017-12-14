package adventofcode2017

import (
	"io/ioutil"
	"sort"
)

func GetInput(day string) (string, error) {
	b, err := ioutil.ReadFile("./../inputs/" + day)
	if err != nil {
		return "", err
	}
	return string(b), nil
}

type sortRunes []rune

func (s sortRunes) Less(i, j int) bool {
	return s[i] < s[j]
}

func (s sortRunes) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

func (s sortRunes) Len() int {
	return len(s)
}

func SortString(s string) string {
	r := []rune(s)
	sort.Sort(sortRunes(r))
	return string(r)
}
