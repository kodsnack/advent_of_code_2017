/*
    I did not feel like writing any unit tests today.
*/
function interrupt(offsetsInput) {
    let offsets = offsetsInput.split('\n').map(number => parseInt(number));
    let currentIndex = 0;
    let steps = 0;
    while(currentIndex >= 0 && currentIndex < offsets.length) {
        let nextIndex = currentIndex + offsets[currentIndex];
        offsets[currentIndex]++;
        currentIndex = nextIndex;
        steps++;
    }
    return steps;
}

function interrupt2(offsetsInput) {
    let offsets = offsetsInput.split('\n').map(number => parseInt(number));
    let currentIndex = 0;
    let steps = 0;
    while(currentIndex >= 0 && currentIndex < offsets.length) {
        let nextIndex = currentIndex + offsets[currentIndex];
        if(offsets[currentIndex] >= 3) {
            offsets[currentIndex]--;
        } else {
            offsets[currentIndex]++;
        }
        currentIndex = nextIndex;
        steps++;
    }
    return steps;
}

function interruptFromFile(path, interruptFunc) {
    let fs = require('fs');
    let offsets = fs.readFileSync(path, 'utf8');
    return interruptFunc(offsets);
}

console.log(interrupt(`0
3
0
1
-3`));

let path = './day05-input.txt'; 
let result = interruptFromFile(path, interrupt);
console.log(result);

console.log(interrupt2(`0
3
0
1
-3`));

let result2 = interruptFromFile(path, interrupt2);
console.log(result2);