package main

import (
	"encoding/hex"
	"fmt"
	"strconv"
)

//////////////////////////////
////////// Typedefs //////////
//////////////////////////////

const debug = true

type listType struct {
	list   []int
	length int
	curPos int
	skip   int
}

/////////////////////////////
////////// Globals //////////
/////////////////////////////

///////////////////////////////
////////// Functions //////////
///////////////////////////////

func makeList(list []int) *listType {
	var l listType
	l.list = list
	l.length = len(list)
	l.curPos = 0
	l.skip = 0
	return &l
}

func reverse(numbers []int) []int {
	for i := 0; i < len(numbers)/2; i++ {
		j := len(numbers) - i - 1
		numbers[i], numbers[j] = numbers[j], numbers[i]
	}
	return numbers
}

func (l *listType) process(length int) {

	selected := []int{}

	if l.curPos+length > l.length {
		selected = append(l.list[l.curPos:], l.list[:((l.curPos+length)%l.length)]...)
	} else {
		selected = l.list[l.curPos : l.curPos+length]
	}
	selected = reverse(selected)
	if l.curPos+length > l.length {
		l.list = append(selected[l.length-l.curPos:], append(l.list[(l.curPos+length)%l.length:l.curPos], selected[:l.length-l.curPos]...)...)
	} else {
		l.list = append(l.list[:l.curPos], append(selected, l.list[l.curPos+length:]...)...)
	}
	l.curPos = (l.curPos + length + l.skip) % l.length
	l.skip++
}

func (l listType) print() {
	s := ""
	s = fmt.Sprintf("listType of length %d, skip %d:\n(", l.length, l.skip)
	for i, v := range l.list {
		if i == l.curPos && i == l.length-1 {
			s += "[" + strconv.Itoa(v) + "] "
		} else if i == l.curPos {
			s += "[" + strconv.Itoa(v) + "], "
		} else if i == l.length-1 {
			s += strconv.Itoa(v)
		} else {
			s += strconv.Itoa(v) + ", "
		}
	}
	s += ")\n"
	fmt.Println(s)
}

//////////////////////////
////////// Main //////////
//////////////////////////

func main() {

	l1 := make([]int, 256)
	for i := range l1 {
		l1[i] = i
	}
	inputs := []int{147, 37, 249, 1, 31, 2, 226, 0, 161, 71, 254, 243, 183, 255, 30, 70}

	/*
		l1 := make([]int, 5)
		for i := range l1 {
			l1[i] = i
		}
		inputs := []int{3, 4, 1, 5}
	*/

	list := makeList(l1)

	fmt.Println("Processing inputs ", inputs)

	for _, v := range inputs {
		list.process(v)
	}

	fmt.Println("\nResulting list object is:")
	list.print()

	l2 := make([]int, 256)
	for i := range l2 {
		l2[i] = i
	}

	//inputs2 := []byte{}
	//inputs2 := []byte("AoC 2017")
	//inputs2 := []byte("1,2,3")
	//inputs2 := []byte("1,2,4")
	inputs2 := []byte("147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70")

	inputs2 = append(inputs2, []byte{17, 31, 73, 47, 23}...)

	inputs3 := make([]int, len(inputs2), len(inputs2))
	for i, v := range inputs2 {
		inputs3[i] = int(v)
	}

	list2 := makeList(l2)

	for i := 0; i < 64; i++ {
		for _, v := range inputs3 {
			list2.process(v)
		}
	}

	list2.print()

	var bytes [16]byte

	for i := 0; i < 16; i++ {
		for j := 0; j < 16; j++ {
			bytes[i] ^= byte(list2.list[i*16+j])
		}
	}

	fmt.Println(bytes)

	fmt.Println(hex.EncodeToString(bytes[:]))

}
