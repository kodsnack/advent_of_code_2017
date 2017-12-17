package util

import (
	"fmt"
)

var Debug bool

func LogInfof(f string, args ...interface{}) {
	fmt.Println(fmt.Sprintf(f, args...))
}

func LogDebugf(f string, args ...interface{}) {
	if Debug {
		fmt.Println(fmt.Sprintf(f, args...))
	}
}

func LogPanicf(f string, args ...interface{}) {
	panic(fmt.Sprintf(f, args...))
}
