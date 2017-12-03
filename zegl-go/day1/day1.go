package day1

import (
	"strings"
	"strconv"
)

func Part1(input string) int {
	sum := 0

	var nums []int

	for _, nStr := range strings.Split(input, "") {
		if n, err := strconv.Atoi(nStr); err == nil {
			nums = append(nums, n)
		}
	}

	// Add first as last
	nums = append(nums, nums[0])

	for i, n := range nums {
		if i == len(nums)-1 {
			break
		}

		if n == nums[i+1] {
			sum += n
		}
	}

	return sum
}

func Part2(input string) int {
	sum := 0

	var nums []int

	for _, nStr := range strings.Split(input, "") {
		if n, err := strconv.Atoi(nStr); err == nil {
			nums = append(nums, n)
		}
	}

	halfLen := len(nums) / 2

	// Add first half to the end
	nums = append(nums, nums[0:halfLen]...)

	for i, n := range nums {
		if i+halfLen < len(nums) && n == nums[i+halfLen] {
			sum += n
		}
	}

	return sum
}
