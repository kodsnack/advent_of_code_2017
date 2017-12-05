const solveA = ({data}) => {
  return data
    .split('\n')
    .filter(p => p)
    .map(passphrase =>
      passphrase
        .split(' ')
        .reduce((acc, word) => {
          acc[word] = acc[word] ? acc[word] + 1 : 1
          acc._valid = acc._valid && acc[word] <= 1
          return acc
        }, {_valid: true})
        ._valid
    )
    .reduce((sum, valid) => valid ? sum + 1 : sum, 0)
}

const solveB = ({data}) => {
  return data
    .split('\n')
    .filter(p => p)
    .map(passphrase =>
      passphrase
        .split(' ')
        .reduce((acc, word) => {
          const sorted = word.split('').sort().join('')
          acc[sorted] = acc[sorted] ? acc[sorted] + 1 : 1
          acc._valid = acc._valid && acc[sorted] <= 1
          return acc
        }, {_valid: true})
        ._valid
    )
    .reduce((sum, valid) => valid ? sum + 1 : sum, 0)
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  console.log('solution to a:', solveA({data}))
  console.log('solution to a:', solveB({data}))
})
