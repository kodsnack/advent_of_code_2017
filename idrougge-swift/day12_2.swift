import Foundation

var input = (try! String.init(contentsOfFile: "day12.txt"))
    .components(separatedBy: .newlines)
    .map{$0.split{", ".contains($0)}
        .flatMap{Int.init($0)}}
var connected = Set<Int>([0])

func drop(_ nodes:[[Int]]) -> [[Int]] {
    let rest = nodes.filter{ connections in
        let connections = Set(connections)
        guard connections.isDisjoint(with: connected) else {
            connected.formUnion(connections)
            return false
        }
        return true
    }
    return rest.count == nodes.count ? rest : drop(rest)
}
var i = 0
while !input.isEmpty {
    connected = Set([input[0][0]])
    input = drop(input)
    i += 1
}
print(i)
