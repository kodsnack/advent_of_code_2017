package util

import (
	"encoding/csv"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

type MyCSVFilterReader struct {
	reader io.Reader
}

func NewMyCSVFilterReader(reader io.Reader) *MyCSVFilterReader {
	p := new(MyCSVFilterReader)
	p.reader = reader
	return p
}

func (this *MyCSVFilterReader) Read(p []byte) (int, error) {
	n, err := this.reader.Read(p)
	if n > 0 {
		for i := 0; i < n; i++ {
			fmt.Printf("%v", p[i])
			if p[i] == '\t' || p[i] == ' ' {
				p[i] = ' '
			}
		}
	}
	fmt.Printf("%v", p)
	return n, err
}

func CSVNumbers(filename string) [][]int {
	f, err := os.Open(filename)
	if err != nil {
		LogPanicf("Unable to open %s. Reason: %v", filename, err)
	}
	r := csv.NewReader(NewMyCSVFilterReader(f))
	r.Comma = ' '
	r.Comment = '#'
	records, err := r.ReadAll()
	if err != nil {
		panic(err)
	}
	numbers := make([][]int, 0)
	for _, row := range records {
		n := make([]int, 0)
		for _, col := range row {
			if strings.Contains(col, " ") {
				LogPanicf("'%s' : Not just numbers", col)
			}
			i, err := strconv.Atoi(col)
			if err != nil {
				panic(err)
			}
			n = append(n, i)
		}
		numbers = append(numbers, n)
	}
	return numbers
}
