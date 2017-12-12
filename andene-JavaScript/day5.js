const fs = require('fs')
const input = fs.readFileSync('day5-input.txt', 'UTF-8');
let offsets = input.split('\n').map(char => parseInt(char))

const solveA = (offsets) => {
    let index = 0
    let steps = 0

    while(index >= 0 && index < offsets.length) {
        const next = offsets[index]
        offsets[index] = (next+1)
        index = index += next
        steps++
    }
    console.log('Steps', steps)
}

const solveB = (offsets) => {
    let index = 0
    let steps = 0

    while(index >= 0 && index < offsets.length) {
        const next = offsets[index]
        offsets[index] = next >= 3 ? next-1 : next+1
        index = index += next
        steps++
    }
    console.log('Steps', steps)
}

// solveA(offsets)
solveB(offsets)



