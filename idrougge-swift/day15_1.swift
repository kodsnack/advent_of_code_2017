import Foundation

struct Generator:Sequence, IteratorProtocol {
    typealias Element = Int
    var val:Int
    let factor:Int
    var count:Int
    mutating func next() -> Generator.Element? {
        guard count > 0 else {return nil}
        count -= 1
        val = val * factor % 0x7fffffff
        return val & 0xffff
    }
}
let a = Generator(val: 703, factor: 16807, count: 40000000)
let b = Generator(val: 516, factor: 48271, count: 40000000)
//let c = zip(a.lazy, b.lazy)
let c = zip(a, b)
    .reduce(0){acc, tuple in 
        let (a,b)=tuple
        return a==b ? acc+1 : acc
    }
print(c)


