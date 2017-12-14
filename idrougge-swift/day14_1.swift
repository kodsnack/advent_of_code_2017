import Foundation

let url = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/advent_of_code_2017/idrougge-rexx/day10.txt")
//let lengths = try! Data.init(contentsOf: url) + [17, 31, 73, 47, 23]
//let lengths = "AoC 2017".data(using: .ascii)! + [17, 31, 73, 47, 23]
//let lengths = "flqrgnkx-0".data(using: .ascii)! + [17, 31, 73, 47, 23]

func knothash(input:String) -> [Int] {
    let listlength = 256
    var list = (0..<listlength).map{$0}
    var pos = 0
    var skip = 0
    let lengths = input.data(using: .ascii)! + [17, 31, 73, 47, 23]
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
    
    return dense
}

func hashToHex(hash:[Int]) -> String {
    let hex = hash.map{String.init(format:"%02x", $0)}.reduce("",+)
    print(hex)
    return hex
}
func hashToBin(hash:[Int]) {
    let bin = hash[0..<1].reduce(""){ str, num in
        let bin = String(num, radix: 2)
        return str + String(repeating: "0", count: 8 - bin.count) + bin
    }
    print(bin)
}
//hashToBin(hash: [15,16,15])
//hashToHex(hash: knothash(input: "AoC 2017"))
//hashToBin(hash: knothash(input: "AoC 2017"))
/*
hashToBin(hash: knothash(input: "flqrgnkx-0"))
*/
func countBits(_ nr:Int) -> Int {
    var nr = nr,  bits = 0
    while nr > 0 {
        nr = nr & (nr-1)
        bits += 1
    }
    return bits
}
var bitcount = 0
(0..<128).forEach{ nr in
    print("flqrgnkx-\(nr)")
    let hash = knothash(input: "ugkiagan-\(nr)")
    bitcount = hash.reduce(bitcount){ acc, val in return acc + countBits(val) }
    print(bitcount)
}
