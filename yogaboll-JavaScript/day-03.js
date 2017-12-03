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
// const input = 49;
const ring = Math.round(Math.sqrt(input - 1) / 2);
const semanticallyMeaninglessVariable =
  (input + ring - (2 * ring - 1) ** 2) % (2 * ring);
const sideSteps = Math.min(
  semanticallyMeaninglessVariable,
  2 * ring - semanticallyMeaninglessVariable
);

const totalSteps = ring + sideSteps;
console.log(sideSteps, ring, totalSteps);
