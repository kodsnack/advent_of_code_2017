import Foundation

var input = (try! String.init(contentsOfFile: "day13.txt"))
    .components(separatedBy: .newlines)
    .map{
        $0.components(separatedBy: ": ")
            .flatMap(Int.init)
}

let severity = input.reduce(0){ score, line in
    let depth = line[0], range = line[1] - 1
    let pos = depth % (range * 2)
    return pos == 0 ? score + depth * (range + 1) : score
}

print(severity)
