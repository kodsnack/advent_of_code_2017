function hasDuplicates(array) {
    var valuesSoFar = Object.create(null);
    for (var i = 0; i < array.length; ++i) {
        var value = array[i];
        if (value in valuesSoFar) {
            return true;
        }
        valuesSoFar[value] = true;
    }
    return false;
}
var lastseen
var cycles = 0;
var x = '';
let memory = '5	1	10	0	1	7	13	14	3	12	8	10	7	12	0	6';
memory = memory.split('\t').map(block => parseInt(block));
var seen = [];
while (1 == 1) {
  var maxin = memory.indexOf(Math.max.apply(this,memory));
  var max = memory[maxin];
  memory[maxin] = 0;
  var p = maxin +1;
  for (var i = 0; i < max; i++, p++) {
    if (p == memory.length) {
      p = 0;
    }
    memory[p]++;
  }
  cycles++;
  lastseen = memory;
  x = memory.join();
  seen.push(x);
  if (hasDuplicates(seen)) {
    break
  }
}
console.log("part 1: " + cycles);
cycles = 0;
x = '';
memory = lastseen;
var seen = [];
while (1 == 1) {
  var maxin = memory.indexOf(Math.max.apply(this,memory));
  var max = memory[maxin];
  memory[maxin] = 0;
  var p = maxin +1;
  for (var i = 0; i < max; i++, p++) {
    if (p == memory.length) {
      p = 0;
    }
    memory[p]++;
  }
  cycles++;
  lastseen = memory;
  x = memory.join();
  seen.push(x);
  if (hasDuplicates(seen)) {
    break
  }
}
console.log("part 2: " + (cycles - 1));

