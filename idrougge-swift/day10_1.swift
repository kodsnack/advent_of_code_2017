import Foundation

let lengths = try! String(contentsOfFile: "day10.txt")
    .components(separatedBy: ",")
    .flatMap(Int.init)
//let lengths = [3,4,1,5]
let listlength = 256
var list = (0..<listlength).map{$0}
var pos = 0
var skip = 0

for len in lengths {
    if pos + len < listlength {
        list[pos ..< pos+len].reverse()
    }
    if pos + len >= listlength {
        let stop = (pos + len) % listlength
        let sub = Array((list[pos...] + list[..<stop]).reversed())
        list[pos...] = sub[..<(listlength - pos)]
        list[..<stop] = sub[(listlength - pos)...]
    }
    pos = (pos + len + skip) % listlength
    skip += 1
}

print(list[0] * list[1])
