const input = 289326
const rows = new Map()
rows.set(`${0},${0}`, 1)
let currentDir = 'right'
let currentX = 0
let currentY = 0
let lastUnOccupiedDir = ''
let found = false

while (!found) {

    const getCoordinatesForDir = (dir) => {
        if (dir === 'right') {
            return { x: currentX + 1, y: currentY }
        }
        if (dir === 'up') {
            return { x: currentX, y: currentY + 1 }
        }
        if (dir === 'down') {
            return { x: currentX, y: currentY - 1 }
        }
        if (dir === 'left') {
            return { y: currentY, x: currentX - 1 }
        }
    }
    const moveAhead = (dir, x, y) => {
        if (dir === 'down') {
            return { x: x, y: y - 1 }
        }
        if (dir === 'right') {
            return { x: x + 1, y: y }
        }
        if (dir === 'up') {
            return { x: x, y: y + 1 }
        }
        if (dir === 'left') {
            return { y: y, x: x - 1 }
        }

    }

    const isOccupied = ({ x, y }) => {
        if (rows.get(`${x},${y}`) || rows.get(`${x},${y}`) === 0) {
            return true
        }
        return false
    }


    const getNextDir = (dir) => {
        if (dir === 'down') {
            return 'right'
        }
        if (dir === 'right') {
            return 'up'
        }
        if (dir === 'up') {
            return 'left'
        }
        if (dir === 'left') {
            return 'down'
        }
    }


    const getSurroundingValues = (x, y) => {

        const minX = x-1
        const maxX = x+1
        const minY =  y-1
        const maxY = y+1
        let sum = 0
        rows.forEach((value, key) => {
            const posValues = key.split(',')
            const posX = parseInt(posValues[0])
            const posY = parseInt(posValues[1])
            if (posX >= minX && posX <= maxX && posY >= minY && posY <= maxY) {
                sum += value
            }
        })
        if(sum > input) {
            console.log(`Yay! ${sum}`)
            found = true
        }
        return sum

    }


    const move = (x, y) => {
        rows.set(`${x},${y}`, getSurroundingValues(x, y))
        currentX = x
        currentY = y
    }

    const { x, y } = getCoordinatesForDir(currentDir)
    if (isOccupied({ x: x, y: y })) {
        let tempX = currentX, tempY = currentY
        let canContinue = false

        while (!canContinue) {
            const nextPosition = moveAhead(lastUnOccupiedDir, tempX, tempY)
            tempX = nextPosition.x
            tempY = nextPosition.y
            if (!isOccupied({ x: tempX, y: tempY })) {
                canContinue = true
                move(tempX, tempY)

            }
        }
    } else {
        move(x, y)
        lastUnOccupiedDir = currentDir
        currentDir = getNextDir(currentDir)
    }
}
