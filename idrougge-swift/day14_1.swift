import Foundation

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
    let hash = knothash(input: "ugkiagan-\(nr)")
    bitcount = hash.reduce(bitcount){ acc, val in return acc + countBits(val) }
}
print(bitcount)
