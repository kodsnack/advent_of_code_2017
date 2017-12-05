package main

import (
  "testing"
)

func TestMainSimple(t *testing.T){
    data := getData("data")
    //data = append(data,data[0])
    result := solve(data,len(data)-1,1)
  if(result != 1251){
    t.Errorf("Error got:%d expected: %d",result,1251)
  }
}

func TestMainSimpleTwo(t *testing.T){
    data := getData("data")
    //data = append(data,data[0])
    result := solve(data,len(data)-1,len(data)/2)
  if(result != 1244){
    t.Errorf("Error got:%d expected: %d",result,1244)
  }
}