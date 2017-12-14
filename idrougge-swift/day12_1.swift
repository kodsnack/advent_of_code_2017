import Foundation

var input = (try! String.init(contentsOfFile: "day12.txt"))
    .components(separatedBy: .newlines)
    .map{
        $0.split{", ".contains($0)}
        .flatMap{Int.init($0)
        }
}
var connected = Set<Int>([0])

func drop(_ nodes:[[Int]]) {
    let a = nodes.filter{ connections in
        let connections = Set(connections)
        guard connections.isDisjoint(with: connected) else {
            connected.formUnion(connections)
            return false
        }
        return true
    }
    if a.count == nodes.count { return }
    return drop(a)
}
drop(input)
print(connected.count)

