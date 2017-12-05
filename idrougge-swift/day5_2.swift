import Foundation

var code=try! String(contentsOfFile: "day5.txt")
    .components(separatedBy: .newlines)
    .flatMap(Int.init)
//var code=[0,3,0,1,-3]
var pc=0, cycles=0
repeat {
    let op=code[pc]
    code[pc] = op + (op>2 ? -1 : 1)
    pc+=op
    cycles+=1
} while pc<code.count
print(cycles)
