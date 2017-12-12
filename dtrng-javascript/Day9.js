const solveA = ({data}) => {
  return data
    .split('')
    .reduce((acc, char) => {
      if (acc.ignore) {
        acc.ignore = false
      } else if (acc.inGarbage) {
        if (char === '>') {
          acc.inGarbage = false
        } else if (char === '!') {
          acc.ignore = true
        }
      } else {
        if (char === '<') {
          acc.inGarbage = true
        } else if (char === '{') {
          acc.groupLevel++
        } else if (char === '}') {
          acc.score += acc.groupLevel
          acc.groupLevel--
        }
      }
      return acc
    }, {groupLevel: 0, inGarbage: false, ignore: false, score: 0})
    .score
}

const solveB = ({data}) => {
  return data
    .split('')
    .reduce((acc, char) => {
      if (acc.ignore) {
        acc.ignore = false
      } else if (acc.inGarbage) {
        if (char === '>') {
          acc.inGarbage = false
        } else if (char === '!') {
          acc.ignore = true
        } else {
          acc.removedChars++
        }
      } else if (char === '<') {
        acc.inGarbage = true
      }
      return acc
    }, {groupLevel: 0, inGarbage: false, ignore: false, removedChars: 0})
    .removedChars
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  data = data.split('\n')[0]
  console.log('solution to a:', solveA({data}))
  console.log('solution to b:', solveB({data}))
})
