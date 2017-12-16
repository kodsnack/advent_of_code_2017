import Foundation

struct Generator:Sequence, IteratorProtocol {
    typealias Element = Int
    var val:Int
    let factor:Int
    let multiplies:Int
    var count:Int
    mutating func next() -> Generator.Element? {
        guard count > 0 else {return nil}
        repeat {
            val = val * factor % 0x7fffffff
        } while val % multiplies > 0
        count -= 1
        return val & 0xffff
    }
}
let a = Generator(val: 703, factor: 16807, multiplies: 4, count: 5000000)
let b = Generator(val: 516, factor: 48271, multiplies: 8, count: 5000000)

let c = zip(a, b)
    .reduce(0){acc, tuple in 
        let (a,b)=tuple
        return a==b ? acc+1 : acc
    }

print(c)