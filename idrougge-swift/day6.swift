import Foundation

extension Array where Element == Int {
    subscript(wrap index:Int) -> Int {
        get { return self[index % self.count] }
        set { self[index % self.count] = newValue }
    }
}

//var banks = [0,2,7,0]
var banks = try! String(contentsOfFile: "day6.txt")
    .components(separatedBy: .whitespaces)
    .flatMap(Int.init)

func distribute(_ banks: inout [Int]) {
    let (start, length) = banks.enumerated().max{$0.element < $1.element}!
    banks[start] = 0
    for i in start+1 ... start+length {
        banks[wrap: i] += 1
    }
}

var permutations = [[Int]]()
var cycles = 0
while !permutations.contains(where: {$0 == banks}) {
    permutations.append(banks)
    distribute(&banks)
    cycles += 1
}

print(cycles) // Puzzle 1
print(cycles - permutations.index(where: {$0 == banks})!) // Puzzle 2