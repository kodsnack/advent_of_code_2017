import Foundation

var input = (try! String.init(contentsOfFile: "day13.txt"))
    .components(separatedBy: .newlines)
    .map{
        $0.components(separatedBy: ": ")
        .flatMap(Int.init)
    }
    .map{($0[0],$0[1])}

let r = (0...).first(where: { delay in
    !input.contains{ depth, range in
        (depth + delay) % ((range - 1) * 2) == 0
    }
})

print(r!)
