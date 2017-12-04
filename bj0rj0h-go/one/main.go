package main

import (
    "fmt"
    "io/ioutil"
    "strconv"
)

func main() {
    data := getData("data")
    result1 := solve(data,len(data)-1,1)
    result2 := solve(data,len(data)-1,len(data)/2)
    fmt.Printf("Result1: %d\n",result1)
    fmt.Printf("Result2: %d\n",result2)
}

func getData(path string) []byte {
    data,err := ioutil.ReadFile(path)
    if err !=nil{
        fmt.Println("Error while reading file")
    }
    return data
}

func solve(data []byte,turns int,split int)  int{
    
    var result int
    size := len(data)
    if data[0] == data[split]{
        result,_ = strconv.Atoi(string(data[0])) 
    }
    if turns == 0{
        return result
    }
    //rotate slice
    newSlice := append(data[size-1:],data[:size-1]...)
    result += solve(newSlice,turns-1,split)
    return result
    
}
