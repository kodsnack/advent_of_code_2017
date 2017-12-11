function calculate(sheet) {
    let rows = sheet.split('\n');
    
    let sum = 0;
    for(let r = 0; r < rows.length; r++) {
        let columns = rows[r].split(/\s/).map(n => parseInt(n));
        let max = Math.max(...columns);
        let min = Math.min(...columns);
        let diff = max - min;
        sum += diff;
    }
    return sum;
}

module.exports.calculate = calculate;

module.exports.calculateFromFile = function(path) {
    let fs = require('fs');
    let sheet = fs.readFileSync(path, 'utf8');
    let checksum = calculate(sheet);
    return checksum; 
}

function calculate2(sheet) {
    let rows = sheet.split('\n');

    let sum = 0;
    for(let r = 0; r < rows.length; r++) {
        let columns = rows[r].split(/\s/).map(n => parseInt(n));
        let result = getEvenlyDivisible(columns);
        let q = result[0] / result[1];
        sum += q;
    }
    return sum;
}

function getEvenlyDivisible(values) {
    for(let v1 = 0; v1 < values.length; v1++) {
        for(let v2 = 0; v2 < values.length; v2++) {
            if(v1 !== v2 && values[v1] % values[v2] === 0) {
                return [values[v1], values[v2]];
            }
        }
    }

    return [];
} 

module.exports.calculate2 = calculate2;
module.exports.getEvenlyDivisible = getEvenlyDivisible;
module.exports.calculate2FromFile = function(path) {
    let fs = require('fs');
    let sheet = fs.readFileSync(path, 'utf8');
    let checksum = calculate2(sheet);
    return checksum; 
}
