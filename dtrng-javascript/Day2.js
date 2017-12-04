const solveA = ({data}) => {
  return data
    .split('\n')
    .filter(a => a)
    .map(row => {
      const sortedNumbers = row
        .split('\t')
        .map(n => +n)
        .sort((a, b) => a - b)
      return sortedNumbers.pop() - sortedNumbers.shift()
    })
    .reduce((sum, diff) => sum + diff)
}

const solveB = ({data}) => {
  return data
    .split('\n')
    .filter(a => a)
    .map(row =>
      row
        .split('\t')
        .map(n => +n)
        .map((n, i, all) => all.find((m, j) => j !== i && m % n === 0) / n)
        .find(n => n)
    )
    .reduce((sum, n) => sum + n)
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  console.log('solution to a:', solveA({data}))
  console.log('solution to a:', solveB({data}))
})
