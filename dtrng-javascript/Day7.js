const solveA = ({data}) => {
  const programs = data
    .split('\n')
    .filter(a => a)
    .map(row => {
      const [, name, weight] = row.match(/([a-z]*)\s\((\d*)\)/)
      const childsString = row.split('->')
      const childs = childsString[1] ? (childsString[1].match(/([a-z]*)/g)).filter(a => a) : []
      return {name, weight, childs}
    })
  const childNames = programs.reduce((childNames, program) => childNames.concat(program.childs), [])
  const rootProgram = programs.find(p => !childNames.includes(p.name))
  return rootProgram.name
}

// all functions below this point is used to solve B

const solveB = ({data}) => {
  const programs = data
    .split('\n')
    .filter(a => a)
    .map(row => {
      const [, name, weight] = row.match(/([a-z]*)\s\((\d*)\)/)
      const childsString = row.split('->')
      const childs = childsString[1] ? (childsString[1].match(/([a-z]*)/g)).filter(a => a) : []
      return {[name]: {weight: +weight, childs}}
    })
    .reduce((dic, program) => Object.assign(program, dic))
  const childNames = Object.values(programs).reduce((childNames, program) => childNames.concat(program.childs), [])
  const rootProgramName = Object.keys(programs).find(p => !childNames.includes(p))

  const weights = computeWeights({programs, name: rootProgramName})
  return findWrongBalance({programs, weights, name: rootProgramName})
}

function computeWeights ({programs, name}) {
  const program = programs[name]
  if (!program.childs.length) {
    return {[name]: +program.weight}
  }

  const programWeights = program.childs.map(n => computeWeights({programs, name: n}))
  const totalWeight = +program.weight + programWeights.map(p => Object.values(p)[0]).reduce((sum, p) => sum + p, 0)

  return programWeights.reduce((o, p) => Object.assign(o, p), {[name]: totalWeight})
}

function findWrongBalance ({programs, weights, name}) {
  const program = programs[name]
  if (program.childs.length === 0) {
    return 0
  }

  const weightSummary = program.childs.map(c => weights[c]).reduce((acc, weight) => {
    acc[weight] = acc[weight] ? acc[weight] + 1 : 1
    return acc
  }, {})
  const majorityWeight = +Object.keys(weightSummary)
    .reduce((acc, weight) => {
      if (acc.count < weightSummary[weight]) {
        acc.count = weightSummary[weight]
        acc.weight = weight
      }
      return acc
    }, {count: 0, weight: 0})
    .weight

  const badChild = program.childs.find(c => Math.abs(weights[c] - majorityWeight) > 0.001)

  if (!badChild) {
    return 0
  } else {
    if (program.childs.length === 2) {
      throw new Error('The assumption of no unbalanced pairs is wrong')
    }

    const correctWeight = findWrongBalance({programs, weights, name: badChild})
    if (correctWeight === 0) {
      return programs[badChild].weight + majorityWeight - weights[badChild]
    }
    return correctWeight
  }
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  console.log('solution to a:', solveA({data}))
  console.log('solution to b:', solveB({data}))
})
