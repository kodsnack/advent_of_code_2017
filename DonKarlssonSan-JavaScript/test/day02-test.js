let checksum = require("../day02-checksum");
let expect = require("chai").expect;

describe("Checksum calculator", function () {
    it("Checksum should be 18", function () {
        let sheet = "5 1 9 5\n7 5 3\n2 4 6 8"; 
        let result = checksum.calculate(sheet);
        expect(result).to.equal(18);
    });

    it("Checksum should be 18 (from file)", function () {
        const path = require('path');
        let filepath = path.join(__dirname, 'day02-testdata.txt');
        let result = checksum.calculateFromFile(filepath);
        expect(result).to.equal(18);
    });

    it("Checksum should be 18 (tab as separator)", function () {
        let sheet = "5\t1\t9\t5\n7\t5\t3\n2\t4\t6\t8"; 
        let result = checksum.calculate(sheet);
        expect(result).to.equal(18);
    });
    
    // it("Day 2, Task 1)", function () {
    //     const path = require('path');
    //     let filepath = path.join(__dirname, 'day02-sheet.txt');
    //     let result = checksum.calculateFromFile(filepath);
    //     console.log(result);
    // });
});

describe("Checksum calculator 2", function () {
    it("getEvenlyDivisable should return 8 and 2", function () {
        let values = [5, 9, 2, 8]; 
        let result = checksum.getEvenlyDivisible(values);
        expect(result[0]).to.equal(8);
        expect(result[1]).to.equal(2);
    });
    
    it("getEvenlyDivisable should return 9 and 3", function () {
        let values = [9, 4, 7, 3]; 
        let result = checksum.getEvenlyDivisible(values);
        expect(result[0]).to.equal(9);
        expect(result[1]).to.equal(3);
    });

    it("Checksum should be 9", function () {
        let sheet = "5 9 2 8\n9 4 7 3\n3 8 6 5"; 
        let result = checksum.calculate2(sheet);
        expect(result).to.equal(9);
    });

    // it("Day 2, Task 2)", function () {
    //     const path = require('path');
    //     let filepath = path.join(__dirname, 'day02-sheet.txt');
    //     let result = checksum.calculate2FromFile(filepath);
    //     console.log(result);
    // });
});