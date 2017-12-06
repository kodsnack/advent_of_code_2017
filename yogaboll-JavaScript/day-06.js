const input = [4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3];
// const input = [0, 2, 7, 0];

const states = [[...input]];

let stateHasDuplicate = false;
let duplicateIndex;
while (!stateHasDuplicate) {
  const largestValue = Math.max(...input);
  const indexOfLargestValue = input.indexOf(Math.max(...input));
  input[indexOfLargestValue] = 0;
  let currentIndex =
    indexOfLargestValue !== input.length - 1 ? indexOfLargestValue + 1 : 0;
  for (let j = largestValue; j > 0; j -= 1) {
    input[currentIndex] = input[currentIndex] + 1;
    if (currentIndex === input.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex += 1;
    }
  }
  // Check for equal array inside states
  if (
    states.filter((state, i) => {
      for (let j = 0; j < state.length; j += 1) {
        if (state[j] !== input[j]) {
          return false;
        }
      }
      duplicateIndex = i;
      return true;
    }).length > 0
  ) {
    stateHasDuplicate = true;
  }
  states.push([...input]);
}
console.log(states.length - 1);
console.log(states.length - 1 - duplicateIndex);
