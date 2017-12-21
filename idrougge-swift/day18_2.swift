import Foundation

let program = try! String(contentsOfFile: "day18.txt")
    .components(separatedBy: .newlines)
    .map{$0.components(separatedBy: .whitespaces)}

class CPU {
    var r:[String:Int] = [:]
    var q:[Int] = []
    weak var other:CPU!
    var pc:Int = 0
    var isLocked:Bool = false
    var sent = 0
    func run() {
        let command = program[pc]
        switch command[0] {
        case "add": add(dest: command[1], term: command[2])
        case "jgz": jgz(term: command[1], offset: command[2])
        case "mod": mod(dest: command[1], divisor: command[2])
        case "mul": mul(dest: command[1], factor: command[2])
        case "rcv": rcv(dest: command[1])
        case "set": set(dest: command[1], val: command[2])
        case "snd": snd(val: command[1])
        default: fatalError()
        }
        pc += 1
    }
    func add(dest:String, term:String) {
        r[dest]! += getval(term)
    }
    func jgz(term:String, offset:String) {
        guard getval(term) > 0 else { return }
        pc += getval(offset) - 1
    }
    func mod(dest:String, divisor:String) {
        r[dest] = getval(dest) % getval(divisor)
    }
    func mul(dest:String, factor:String) {
        r[dest] = r[dest]! * getval(factor)
    }
    func rcv(dest:String) {
        guard let val = q.first else {
            pc -= 1
            isLocked = true
            return
        }
        r[dest] = val
        q.removeFirst()
        isLocked = false
    }
    func set(dest:String,val:String) {
        r[dest] = getval(val)
    }
    func snd(val:String) {
        other.q.append(getval(val))
        sent += 1
    }
    
    func getval(_ val:String) -> Int {
        return Int(val) ?? r[val]!
    }
}

let a = CPU()
a.r["p"] = 0
let b = CPU()
b.r["p"] = 1
a.other = b
b.other = a

var cycles = 0
while !a.isLocked || !b.isLocked {
    a.run()
    b.run()
    cycles += 1
}
print(b.sent)
