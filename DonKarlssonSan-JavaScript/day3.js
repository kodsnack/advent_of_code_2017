/*
37  36  35  34  33  32  31 
38  17  16  15  14  13  30
39  18   5   4   3  12  29
40  19   6   1   2  11  28
41  20   7   8   9  10  27
42  21  22  23  24  25  26
43  44  45  46  47  48  49
*/

module.exports.steps = function(sq) {
    let value = 1;
    let values = new Map();
    let x = 0;
    let y = 0;
    addCurrent();
    let sideLength = 1;
    while(sideLength * sideLength < sq) {
        sideLength += 2;
        addPositionsForRing(sideLength);
    } 
    return Math.abs(values.get(sq)[0]) + Math.abs(values.get(sq)[1]);

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
}

module.exports.firstValueLargerThan = function(maxVal) {
    let values = new Map();
    let x = 0;
    let y = 0;
    let sideLength = 1;
    let max = maxVal;
    values.set(`${x},${y}`, 1);
    try {
        while(true) {
            sideLength += 2;
            addValuesForRing(sideLength);
        } 
    } catch(value) {
        return value;
    }
    return 0;

    function addValuesForRing(sideLength) {
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
        let value = getSumOfAdjecent();
        values.set(`${x},${y}`, value);
        if(value > max) {
            // This is so ugly code that I wan to throw up.
            throw value;
        }
    }

    function getSumOfAdjecent() {
        let sum = 0;
        for(let col = -1; col < 2; col++) {
            for(let row = -1; row < 2; row++) {
                let isCenter = col === 0 && row === 0;
                if(!isCenter) {
                    let key = `${x + col},${y + row}`;
                    sum += values.get(key) || 0;
                }
            }
        }
        return sum;
    }
}
