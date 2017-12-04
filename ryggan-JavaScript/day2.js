import fs from 'fs';
const input = fs.readFileSync('./day2input.txt', 'utf8');

const rows = input.split('\n');

const sum1 = rows.reduce((acc, row) => {
  const rowResult = row.split('\t').reduce((acc, n) => {
    n = Number(n);
    if (n < acc.min) {
      acc.min = n;
    }
    if (n > acc.max) {
      acc.max = n;
    }
    return acc;
  }, { min: 10000, max: 0 });
  const { min, max } = rowResult;
  return acc + (max - min);
}, 0);

console.log('Uppgift 1: ' + sum1);

let t = 0;
const sum2 = rows.reduce((acc, row) => {
  const rowResult = row.split('\t').reduce((acc, n) => {
    n = Number(n);
    let div = -1;
    row.split('\t').map(d => {
      d = Number(d);
      if (d < n && n % d === 0) {
        div = d;
      }
    });

    if (div === -1) {
      return acc;
    }
    return (acc = n / div);
  }, 0);
  return (acc += rowResult);
}, 0);

console.log('Uppgift 2: ' + sum2);
