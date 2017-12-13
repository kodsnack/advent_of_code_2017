import Foundation

let url = URL(fileURLWithPath: "day10.txt")
let lengths = try! Data.init(contentsOf: url) + [17, 31, 73, 47, 23]
//let lengths = "AoC 2017".data(using: .ascii)! + [17, 31, 73, 47, 23]
let listlength = 256
var list = (0..<listlength).map{$0}
var pos = 0
var skip = 0

for _ in 1...64 {
    for l in lengths {
        let len = Int(l)
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
}

var dense = [Int]()
for i in stride(from: 0, to: listlength, by: 16) {
    dense.append(list[i..<i+16].reduce(0, ^))
}

let hex = dense.map{String.init(format:"%02x", $0)}.reduce("",+)
print(hex)
