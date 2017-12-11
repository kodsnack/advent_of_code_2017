package day10

import (
	"strings"
	"strconv"
	"encoding/hex"
)

func Part1(listLen int, input string) int {
	list := make([]int, listLen)
	for i := 0; i < listLen; i++ {
		list[i] = i
	}

	skipSize := 0
	pos := 0

	for _, inputLenStr := range strings.Split(input, ",") {
		inputLen, err := strconv.Atoi(strings.TrimSpace(inputLenStr))
		if err != nil {
			panic(err)
		}

		slice := make([]int, inputLen)
		rev := make([]int, inputLen)
		for i := 0; i < inputLen; i++ {
			slice[i] = list[(pos+i)%len(list)]
			rev[inputLen-1-i] = slice[i]
		}
		for i := 0; i < inputLen; i++ {
			list[(pos+i)%len(list)] = rev[i]
		}

		pos = pos + skipSize + inputLen
		skipSize++
	}

	return list[0] * list[1]
}

func Knot(input []byte) ([]int) {
	listLen := 256
	list := make([]int, listLen)
	for i := 0; i < listLen; i++ {
		list[i] = i
	}

	skipSize := 0
	pos := 0

	for i := 0; i < 64; i++ {
		for _, inputByte := range input {
			inputLen := int(inputByte)

			slice := make([]int, inputLen)
			rev := make([]int, inputLen)
			for i := 0; i < inputLen; i++ {
				slice[i] = list[(pos+i)%len(list)]
				rev[inputLen-1-i] = slice[i]
			}
			for i := 0; i < inputLen; i++ {
				list[(pos+i)%len(list)] = rev[i]
			}

			pos = pos + skipSize + inputLen
			skipSize++
		}
	}

	return list
}

func Part2(input string) string {
	input = strings.TrimSpace(input)

	// Convert to ASCII
	lengths := make([]byte, len(input))
	for i := 0; i < len(input); i++ {
		lengths[i] = input[i]
	}

	// Add suffix values
	lengths = append(lengths, 17, 31, 73, 47, 23)
	return DenseHash(Knot(lengths))
}

func DenseHash(list []int) string {
	denseHash := make([]byte, len(list)/16)
	for i := 0; i < len(list); i += 16 {
		for j := 0; j < 16; j++ {
			denseHash[i/16] ^= byte(list[i+j])
		}
	}
	return hex.EncodeToString(denseHash)
}
