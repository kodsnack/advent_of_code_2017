const parsePrograms = ({data}) => {
  return data.split('\n')
    .map(l => {
      const [program, ...connections] = l.replace(' <-> ', ', ').split(', ').map(n => +n)
      return {[program]: connections}
    })
    .reduce((acc, p) => Object.assign({}, p, acc), {})
}

const solveA = ({data}) => findAllInGroup({programs: parsePrograms({data}), program: 0})

const solveB = ({data}) => {
  const programs = parsePrograms({data})
  let groups = 0
  while (Object.keys(programs).length) {
    findAllInGroup({programs, program: Object.keys(programs).pop()})
    groups++
  }
  return groups
}

function findAllInGroup ({programs, program}) {
  if (!programs[program]) {
    return 0
  }

  const connections = programs[program]
  delete programs[program]
  return connections
    .map(p => findAllInGroup({programs, program: p}))
    .reduce((sum, c) => sum + c, 1)
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  console.log('solution to a:', solveA({data}))
  console.log('solution to b:', solveB({data}))
})
