function calculate(input, length) {
    let lengths = input.split(', ').map(l => parseInt(l));
    let currentPos = 0;
    let skipSize = 0;
    let list = [];
    for(let i = 0; i < length; i++) {
        list.push(i);
    }
    for(let i = 0; i < lengths.length; i++) {
        let len = lengths[i];
        reverse(list, currentPos, len);
        currentPos += len + skipSize;
        skipSize++;
    }
    return list[0] * list[1];
}

function reverse(input, start, length) {
    for(var i = 0; i < length / 2; i++) {
        let i1 = (start + i) % input.length;
        let i2 = (start + length - 1 - i) % input.length; 
        let temp = input[i1];
        input[i1] = input[i2];
        input[i2] = temp;
    }
}

module.exports.calculate = calculate; 
