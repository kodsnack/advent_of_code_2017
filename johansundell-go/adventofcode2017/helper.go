package adventofcode2017

import "io/ioutil"

func GetInput(day string) (string, error) {
	b, err := ioutil.ReadFile("./../inputs/" + day)
	if err != nil {
		return "", err
	}
	return string(b), nil
}
