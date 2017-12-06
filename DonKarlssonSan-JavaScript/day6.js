function reallocate(memoryInput) {
    let memory = memoryInput.split('\t').map(block => parseInt(block));
    let states = new Set();
    states.add(memory.join(','));
    let cycles = 0;
    let previousStatesSize = 0;
    do {
        let max = 0;
        let mostBlocksIndex;
        memory.forEach((m, i) => {
            if(m > max) {
                max = m;
                mostBlocksIndex = i;
            }
        });
        let blocks = memory[mostBlocksIndex];
        memory[mostBlocksIndex] = 0;
        let currentIndex = mostBlocksIndex + 1;
        do {    
            if(currentIndex >= memory.length) {
                currentIndex = 0;
            }
            memory[currentIndex]++;
            blocks--;
            currentIndex++;
        } while(blocks > 0)
        previousStatesSize = states.size;
        states.add(memory.join(','));
        cycles++;
    } while(previousStatesSize !== states.size)
    console.log('State already seen: ' + [...states.values()].pop());
    return cycles;
}

let memory = '0\t2\t7\t0';
let result = reallocate(memory);
console.log('Cycles for example: ' + result);

memory = '10	3	15	10	5	15	5	15	9	2	5	8	5	2	3	6';
result = reallocate(memory);
console.log('Cycles for part 1: ' + result);

memory = '0	1	14	14	13	12	11	9	9	8	7	6	5	3	2	4';
result = reallocate(memory);
console.log('Cycles for part 2: ' + result);