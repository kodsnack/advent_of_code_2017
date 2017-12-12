function walk(instructionsIn) {
    let x = 0;
    let y = 0;
    let maxSteps = 0;
    let angles = new Map([
        ['ne', Math.PI/6],
        ['n', Math.PI/6*3],
        ['nw', Math.PI/6*5],
        ['sw', Math.PI/6*7],
        ['s', Math.PI/6*9],
        ['se', Math.PI/6*11],
    ]);
    let instructions = instructionsIn.split(',');
    instructions.forEach(instruction => {
        let angle = angles.get(instruction);
        x += Math.cos(angle);
        y += Math.sin(angle);
        let steps = calculateShortestWayBack(x, y);
        if(steps > maxSteps) {
            maxSteps = steps;
        }
    });
    let steps = calculateShortestWayBack(x, y);
    return [steps, maxSteps];
}

function calculateShortestWayBack(x, y) {
    let x1 = Math.round(Math.abs(x/0.8660254037844387));
    let y1 = Math.round(Math.abs(y*2));
    if(x1 === y1) {
        return x1;
    } else if(y1 > x1) {
        return (y1 - x1) / 2 + x1;
    } else return x1;
}

module.exports.walk = walk;
