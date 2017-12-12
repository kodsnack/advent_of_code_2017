const input = 289326

const circles = []
circles.push([1])

const numberToFind = input

let nextItem = 2

const add = (circle) => {
    const lastAddedCircle = circles[circles.length-1]
    circles.push(circle)
    const start = lastAddedCircle[lastAddedCircle.length-1]
    const numberInCircle = (8*circles.length)
    loop(start, numberInCircle+start)
}

const loop = (start, end) => {
    if(end > input) return;
    let nextCircle = []
    for(let i = start; i < end ; i++) {
        nextCircle.push(nextItem++)
    }
    add(nextCircle)
}

loop(2, 10)


circles.forEach((childArray, circleIdx) => {

    const hasNumber = childArray.indexOf(numberToFind)
    if(hasNumber > -1) {
        const lineLength = childArray.length/4

        const right = [childArray[childArray.length-1],...childArray.slice(0, lineLength)]
        const top = [right[right.length-1],...childArray.slice(lineLength, lineLength*2)]
        const left = [top[top.length-1],...childArray.slice(lineLength*2, lineLength*3)]
        const bottom = [left[left.length-1],...childArray.slice(lineLength*3, lineLength*4)]
        const centerIndex = lineLength/2;

        let currentPos
        currentPos = right.indexOf(numberToFind)
        if(currentPos < 0) {
            currentPos = top.indexOf(numberToFind)
        }
        if(currentPos < 0) {
            currentPos = left.indexOf(numberToFind)
        }
        if(currentPos < 0) {
            currentPos = bottom.indexOf(numberToFind)
        }

        let steps = -1;
        if(currentPos > centerIndex) {
            steps = currentPos-centerIndex
        } else {
            steps = centerIndex-currentPos
        }

        console.log('Move',steps+circleIdx)
        // console.log(right, top, left, bottom)
    }
})