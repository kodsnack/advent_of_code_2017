/* prettier-ignore */
const cipher = [130,126,1,11,140,2,255,207,18,254,246,164,29,104,0,224]

// För varje nummer i chiffret ska vi:
// 1. Ta en del av listan som börjar på curPos och är input[i] långt, och vänd på den (kom ihåg att listan är cirkulär)
// 2. curPos rör sig frammåt med input[i] + skipSize
// 3. skipSize ökar med 1

// let curPos = 0;
// const originalList = Array.from(Array(256).keys());

// const hashedList = cipher.reduce((list, subListLength, skipSize) => {
//   // Fixa så att listan börjar om från början när slutet nås
//   const newList = Array.from(list);

//   if (curPos + subListLength <= originalList.length) {
//     const subList = newList.splice(curPos, subListLength).reverse();
//     newList.splice(curPos, 0, ...subList);
//   } else {
//     // Ta sista delen från newList (curPos till 255) och sedan ta delen från 0 till resterande subListLength

//     const endList = newList.splice(curPos);
//     const startList = newList.splice(
//       0,
//       subListLength - originalList.length + curPos
//     );
//     const subList = [...endList, ...startList];
//     subList.reverse();

//     const newEndList = subList.splice(0, endList.length);
//     const newStartList = subList;

//     newList.splice(0, 0, ...newStartList);
//     newList.splice(newList.length, 0, ...newEndList);
//   }

//   curPos = (curPos + subListLength + skipSize) % 256;
//   return newList;
// }, originalList);

// PART II
// Convert string to array of ascii codes followed by [17, 31, 73, 47, 23]
// Then do the same things as before but 64 times and preserve curPos and skipSize between goarounds
// Convert the sparse hash to dense hash with xor for every group of 16 elements
// We now have an array of 16 numbers that will be convert to a string where ever number is two hex digits
const cipherString = "130,126,1,11,140,2,255,207,18,254,246,164,29,104,0,224";
// const cipherString = "AoC 2017";

const asciiArray = [
  ...cipherString.split("").map(char => char.charCodeAt(0)),
  17,
  31,
  73,
  47,
  23
];

let curPos = 0;
let skipSize = 0;
const indexList = Array.from(Array(256).keys());

const hash = originalList =>
  asciiArray.reduce((list, subListLength) => {
    // Fixa så att listan börjar om från början när slutet nås
    const newList = Array.from(list);

    if (curPos + subListLength <= originalList.length) {
      const subList = newList.splice(curPos, subListLength).reverse();
      newList.splice(curPos, 0, ...subList);
    } else {
      // Ta sista delen från newList (curPos till 255) och sedan ta delen från 0 till resterande subListLength

      const endList = newList.splice(curPos);
      const startList = newList.splice(
        0,
        subListLength - originalList.length + curPos
      );
      const subList = [...endList, ...startList];
      subList.reverse();

      const newEndList = subList.splice(0, endList.length);
      const newStartList = subList;

      newList.splice(0, 0, ...newStartList);
      newList.splice(newList.length, 0, ...newEndList);
    }

    curPos = (curPos + subListLength + skipSize) % 256;
    skipSize += 1;
    return newList;
  }, originalList);

let hashedList = hash(indexList);

for (let i = 1; i < 64; i += 1) {
  hashedList = hash(hashedList);
}

const hexBlocks = [];
hashedList.forEach((value, i) => {
  if (i % 16 === 0) {
    hexBlocks.push([value]);
  } else {
    hexBlocks[hexBlocks.length - 1].push(value);
  }
});

const denseHash = hexBlocks.map(block => {
  return block.reduce((acc, num) => acc ^ num);
});

const hexHash = denseHash
  .map(val => val.toString(16).padStart(2, "0"))
  .join("");

console.log(denseHash);
console.log(hexBlocks);
console.log(hexHash);

// result = e146210a34221a7f0906da15c1c979a
// a2582a3ae66e6e86e3812dcb672a272;
// a2582a3a0e66e6e86e3812dcb672a272;
