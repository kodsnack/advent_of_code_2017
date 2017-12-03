/*
37  36  35  34  33  32  31 
38  17  16  15  14  13  30
39  18   5   4   3  12  29
40  19   6   1   2  11  28
41  20   7   8   9  10  27
42  21  22  23  24  25  26
43  44  45  46  47  48  49
*/
let value;
let values = new Map();
let x, y;
function steps(sq) {

    value = 1;
    x = 0;
    y = 0;
    addCurrent();
    let sideLength = 1;
    while((sideLength)*(sideLength)<sq) {
        sideLength += 2;
        addPositionsForRing(sideLength);
    } 
    return Math.abs(values.get(sq)[0]) + Math.abs(values.get(sq)[1]);
}

function addPositionsForRing(sideLength) {
    x++;
    addRightSide(sideLength);
    addTopSide(sideLength);
    addLeftSide(sideLength);
    addBottomSide(sideLength);
}

function addRightSide(sideLength) {
    for(let i = 0; i < sideLength - 1; i++) {
        addCurrent();
        y++;
    }
    y--;
}

function addTopSide(sideLength) {
    for(let i = 0; i < sideLength - 1; i++) {
        x--;
        addCurrent();
    }
}

function addLeftSide(sideLength) {
    for(let i = 0; i < sideLength - 1; i++) {
        y--;    
        addCurrent();
    }
}

function addBottomSide(sideLength) {
    for(let i = 0; i < sideLength - 1; i++) {
        x++;
        addCurrent();
    }
}

function addCurrent() {
    values.set(value, [x, y]);
    value++;
}

module.exports.steps = steps;
