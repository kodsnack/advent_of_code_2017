/* stepsToRing:
1 ** 2 : 0
1 ** 2 + 1 -> 3**2 : 1
3**2 + 1 -> 5**2 : 2
5**2 + 1 -> 7**2 : 3

Steps from middle to number

1: (number -1 + 1) % 2
2: Math.min((number - 3**2 + 2) % 4, 4 - ((number - 3**2 + 2) % 4)
3: Math.min((number - 5**2 + 3) % 6, 6 - ((number - 5**2 + 3) % 6)
4: Math.min((number - 7**2 + 4) % 8, 8 - ((number - 7**2 + 4) % 8)

*/

const input = 312051;

// Day 3a
const ring = Math.round(Math.sqrt(input - 1) / 2);
const semanticallyMeaninglessVariable =
  (input + ring - (2 * ring - 1) ** 2) % (2 * ring);
const sideSteps = Math.min(
  semanticallyMeaninglessVariable,
  2 * ring - semanticallyMeaninglessVariable
);

const totalSteps = ring + sideSteps;
console.log(totalSteps);

// Day 3b

const squares = [{ x: 0, y: 0, value: 1 }];
const directions = ["down", "right", "up", "left"];
for (let i = 1; squares[squares.length - 1].value < input; i += 1) {
  const direction = directions[i % 4];
  for (
    let j = 0;
    j < Math.round(i / 2) && squares[squares.length - 1].value < input;
    j += 1
  ) {
    let x;
    let y;
    if (direction === "down") {
      x = squares[squares.length - 1].x;
      y = squares[squares.length - 1].y - 1;
    } else if (direction === "right") {
      x = squares[squares.length - 1].x + 1;
      y = squares[squares.length - 1].y;
    } else if (direction === "up") {
      x = squares[squares.length - 1].x;
      y = squares[squares.length - 1].y + 1;
    } else {
      x = squares[squares.length - 1].x - 1;
      y = squares[squares.length - 1].y;
    }
    const adjacentSquares = squares.filter(
      square => Math.abs(square.x - x) < 2 && Math.abs(square.y - y) < 2
    );
    const value = adjacentSquares.reduce(
      (acc, square) => acc + square.value,
      0
    );
    squares.push({ x, y, value });
    console.log("value: ", value);
  }
}
