const solveA = ({data}) => {
  const instructions = data.split('\n').filter(n => n).map(n => +n)
  let i = 0
  let steps = 0
  while (i < instructions.length) {
    const next = instructions[i] + i
    instructions[i]++
    i = next
    steps++
  }
  return steps
}

const solveB = ({data}) => {
  const instructions = data.split('\n').filter(n => n).map(n => +n)
  let i = 0
  let steps = 0
  while (i < instructions.length) {
    const next = instructions[i] + i
    instructions[i] += instructions[i] < 3 ? 1 : -1
    i = next
    steps++
  }
  return steps
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  console.log('solution to a:', solveA({data}))
  console.log('solution to a:', solveB({data}))
})
