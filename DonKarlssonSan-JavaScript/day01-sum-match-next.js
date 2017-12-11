module.exports.sum = function(numberString) {
    let numbers = numberString.split('').map(n => parseInt(n));
    let sum = 0;

    for(let i = 0; i < numbers.length; i++) {
        let next = i + 1;
        if(next >= numbers.length) {
            next = 0;
        }
        if(numbers[i] === numbers[next]) {
            sum += numbers[i];
        }
    }
    return sum;
}

module.exports.sum2 = function(numberString) {
    let numbers = numberString.split('').map(n => parseInt(n));
    let sum = 0;

    for(let i = 0; i < numbers.length; i++) {
        let next = i + numbers.length/2;
        if(next >= numbers.length) {
            next = next - numbers.length;
        }
        if(numbers[i] === numbers[next]) {
            sum += numbers[i];
        }
    }
    return sum;
}