const solveA = ({data}) => {
  const oneOff = (data.substring(1) + data.substring(0, 1)).split('')
  return data
    .split('')
    .map(c => [c, oneOff.shift()])
    .filter(pair => pair[0] === pair[1])
    .map(pair => pair[0])
    .reduce((sum, digit) => sum + +digit, 0)
}

const solveB = ({data}) => {
  const otherSide = (data.substring(data.length / 2) + data.substring(0, data.length / 2)).split('')
  return data
    .split('')
    .map(c => [c, otherSide.shift()])
    .filter(pair => pair[0] === pair[1])
    .map(pair => pair[0])
    .reduce((sum, digit) => sum + +digit, 0)
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  const onlyDigits = data.replace(/\r?\n|\r/g, '')
  console.log('solution to a:', solveA({data: onlyDigits}))
  console.log('solution to a:', solveB({data: onlyDigits}))
})
