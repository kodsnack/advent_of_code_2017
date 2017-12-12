const solveA = ({data, N}) => {
  let tmp = []
  tmp[N - 1] = 0
  const nums = tmp.fill(0).map((x, i) => i)
  let position = 0
  data.split(',').map(x => +x).forEach((length, skip) => {
    for (let i = position; i < Math.floor(position + length / 2); i++) {
      const start = i % N
      const end = (2 * position + length - 1 - i) % N
      const temp = nums[start]
      nums[start] = nums[end]
      nums[end] = temp
    }
    position = (position + skip + length) % N
  })
  return nums[0] * nums[1]
}

const solveB = ({data, N}) => {
  let tmp = []
  tmp[N - 1] = 0
  const nums = tmp.fill(0).map((x, i) => i)
  let position = 0
  let skip = 0
  const lengths = data.split('').filter(x => x).map(x => x.charCodeAt(0)).concat([17, 31, 73, 47, 23])
  for (let round = 0; round < 64; round++) {
    lengths.forEach(length => {
      for (let i = position; i < Math.floor(position + length / 2); i++) {
        const start = i % N
        const end = (2 * position + length - 1 - i) % N
        const temp = nums[start]
        nums[start] = nums[end]
        nums[end] = temp
      }
      position = (position + skip + length) % N
      skip++
    })
  }

  const denseHash = []
  for (let i = 0; i < 16; i++) {
    denseHash[i] = 0
    for (let j = 0; j < 16; j++) {
      denseHash[i] = denseHash[i] ^ nums[16 * i + j]
    }
    denseHash[i] = denseHash[i].toString(16)
    denseHash[i] = denseHash[i].length === 1 ? '0' + denseHash[i] : denseHash[i]
  }

  return denseHash.join('')
}

require('fs').readFile('input.txt', 'utf8', (err, data) => {
  if (err) { console.error(err); return }
  data = data.split('\n')[0]
  console.log('solution to a:', solveA({data, N: 256}))
  console.log('solution to b:', solveB({data, N: 256}))
})
