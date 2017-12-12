const fs = require('fs')
const input = fs.readFileSync('./day4-input.txt', 'UTF-8')

const solveA = (input) => {
    return input.split('\n')
        .map(row => row.split(' ').map((word, idx, arr) => arr.indexOf(word) === idx))
        .filter(wordArray => wordArray.indexOf(false) <= -1)
        .length
}

const solveB = (input) => {
    return input.split('\n')
        .map(row => row.split(' '))
        .map(words => words.map(word => word.split('').sort().join('')))
        .map(sortedWords => sortedWords.map((word, idx, words) => words.indexOf(word) === idx))
        .filter(wordArray => wordArray.indexOf(false) <= -1)
        .length
}

console.log(solveA(input))
console.log(solveB(input))