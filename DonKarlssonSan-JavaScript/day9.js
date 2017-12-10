function process(stream) {
    let level = 0;
    let score = 0;
    let chars = stream.split('');
    let isGarbage = false;
    let ignoreNext = false;
    chars.forEach(c => {
        if(ignoreNext) {
            ignoreNext = false;
        } else {
            if(c === '{' && !isGarbage) {
                level++;
                score += level;
            } else if(c === '}' && !isGarbage) {
                level--;
            } else if(c === '<') {
                isGarbage = true;
            } else if(c === '>') {
                isGarbage = false;
            } else if(c === '!') {
                ignoreNext = true;
            }
        }
    });
    return score;
}

function countGarbage(stream) {
    let garbageCount = 0;
    let chars = stream.split('');
    let isGarbage = false;
    let ignoreNext = false;
    chars.forEach(c => {
        if(ignoreNext) {
            ignoreNext = false;
        } else {
            if(isGarbage && c !== '!' && c !== '>') {
                garbageCount++;
            } else if(c === '<') {
                isGarbage = true;
            } else if(c === '>') {
                isGarbage = false;
            } else if(c === '!') {
                ignoreNext = true;
            }
        }
    });
    return garbageCount;
}

module.exports.process = process; 
module.exports.countGarbage = countGarbage;