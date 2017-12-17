package day10

import (
	"AdventOfCode2017/util"
	"fmt"
)

type KnotHash struct {
	circularList         []byte
	circularListPos      int
	circularListSkipSize int
	DenseHash            string
}

func (kh *KnotHash) reverse(l byte) {
	//util.LogInfof("********************************")
	//util.LogInfof("circularListPos=%d circularListSkipSize=%d l=%d circularList=%v", kh.circularListPos, kh.circularListSkipSize, l, kh.circularList)
	n := make([]byte, l)
	pos := kh.circularListPos
	for i := 0; i < int(l); i++ {
		n[i] = kh.circularList[pos]
		pos++
		if pos == len(kh.circularList) {
			pos = 0
		}
	}
	//util.LogInfof("circularListPos= %d l=%d n=%v", kh.circularListPos, l, n)
	for i, j := 0, int(l)-1; i < j; i, j = i+1, j-1 {
		n[i], n[j] = n[j], n[i]
	}
	//util.LogInfof("circularListPos= %d l=%d n=%v", kh.circularListPos, l, n)
	for _, i := range n {
		kh.circularList[kh.circularListPos] = i
		kh.circularListPos++
		if kh.circularListPos == len(kh.circularList) {
			kh.circularListPos = 0
		}
	}
	for i := 0; i < kh.circularListSkipSize; i++ {
		kh.circularListPos++
		if kh.circularListPos == len(kh.circularList) {
			kh.circularListPos = 0
		}
	}
	kh.circularListSkipSize++
	//util.LogInfof("circularListPos=%d circularListSkipSize=%d l=%d circularList=%v", kh.circularListPos, kh.circularListSkipSize, l, kh.circularList)
}

func (kh *KnotHash) result1() int {
	return int(kh.circularList[0]) * int(kh.circularList[1])
}

func (kh *KnotHash) CalcDenseHash() {
	denseHash := make([]byte, 16)
	for x := 0; x < 16; x++ {
		for y := 0; y < 16; y++ {
			denseHash[x] ^= kh.circularList[x*16+y]
		}
	}
	for x := 0; x < 16; x++ {
		kh.DenseHash += fmt.Sprintf("%02x", denseHash[x])
	}
}

func NewKnotHash(filename string, circularListLen int) *KnotHash {
	kh := new(KnotHash)
	kh.circularList = make([]byte, circularListLen)
	//
	// CircularList
	for i := 0; i < len(kh.circularList); i++ {
		kh.circularList[i] = byte(i)
	}
	//
	// Input
	input := util.FileAsSeparatedSingleLineNumbers(filename, ",")
	//
	//
	for _, i := range input {
		kh.reverse(byte(i))
	}
	return kh
}

func NewKnotHashPartTwo(input string, circularListLen int) *KnotHash {
	kh := new(KnotHash)
	kh.circularList = make([]byte, circularListLen)
	//
	// CircularList
	for i := 0; i < len(kh.circularList); i++ {
		kh.circularList[i] = byte(i)
	}
	//
	//
	for x := 0; x < 64; x++ {
		for _, i := range []byte(input) {
			kh.reverse(i)
		}
		for _, b := range []byte{17, 31, 73, 47, 23} {
			kh.reverse(b)
		}
	}
	kh.CalcDenseHash()
	return kh
}

func NewKnotHashDay14(input string) string {
	kh := new(KnotHash)
	kh.circularList = make([]byte, 256)
	//
	// CircularList
	for i := 0; i < len(kh.circularList); i++ {
		kh.circularList[i] = byte(i)
	}
	//
	//
	//
	//
	for x := 0; x < 64; x++ {
		for _, i := range []byte(input) {
			kh.reverse(i)
		}
	}
	kh.CalcDenseHash()
	return kh.DenseHash
}
