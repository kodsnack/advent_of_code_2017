const fs = require('fs')
const raw = fs.readFileSync('day6-input.txt', 'UTF-8');

let banks = raw.split('\t').map(char => parseInt(char))

// banks =  [0, 2, 7, 0]

let infiniteLoopDetected = false
let previousValues = []
let idxFirst = 0

const spreadBlocks = (indexHighestNumber, numberOfSteps) => {
    for(let i = 0; i < numberOfSteps; i++) {
        banks[(indexHighestNumber+(i+1)) % banks.length] += 1
    }
    const save = banks.reduce((a, b) => {
        return a.toString() + b.toString()
    }, '')

    infiniteLoopDetected = previousValues.includes(save) ? true : false

    if(infiniteLoopDetected) {
        idxFirst = previousValues.indexOf(save)
    }
    previousValues.push(save)
}

while(!infiniteLoopDetected) {
    const indexHighestNumber = banks.indexOf(Math.max(...banks))
    const numberOfSteps = banks[indexHighestNumber]
    banks[indexHighestNumber] = 0
    spreadBlocks(indexHighestNumber, numberOfSteps)
}

console.log(previousValues.length, previousValues.slice(idxFirst, previousValues.length).length-1)
