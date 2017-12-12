const solveA = ({data}) => {
  const operations = {
    '<': (l, r) => l < r,
    '>': (l, r) => l > r,
    '<=': (l, r) => l <= r,
    '==': (l, r) => l === r,
    '>=': (l, r) => l >= r,
    '!=': (l, r) => l !== r,
    'inc': v => v,
    'dec': v => -v,
  }
  const registers = data
    .split('\n')
    .filter(l => l)
    .map(l => l.split(' '))
    .reduce((registers, [register, op, amount, , left, condition, right]) => {
      if (operations[condition](registers[left] || 0, +right)) {
        registers[register] = (registers[register] || 0) + operations[op](+amount)
      }
      return registers
    }, {})
  return Object.values(registers).sort((a, b) => b - a)[0]
}

const solveB = ({data}) => {
  const operations = {
    '<': (l, r) => l < r,
    '>': (l, r) => l > r,
    '<=': (l, r) => l <= r,
    '==': (l, r) => l === r,
    '>=': (l, r) => l >= r,
    '!=': (l, r) => l !== r,
    'inc': v => v,
    'dec': v => -v,
  }
  const registers = data
    .split('\n')
    .filter(l => l)
    .map(l => l.split(' '))
    .reduce((registers, [register, op, amount, , left, condition, right]) => {
      if (operations[condition](registers[left] || 0, +right)) {
        registers[register] = (registers[register] || 0) + operations[op](+amount)
        registers._max = Math.max(registers._max, registers[register])
      }
      return registers
    }, {_max: 0})
  return registers._max
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  console.log('solution to a:', solveA({data}))
  console.log('solution to a:', solveB({data}))
})
