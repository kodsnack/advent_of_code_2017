let day3 = require("../day03");
let expect = require("chai").expect;

describe("Day 3, Part 1", function () {
    it("should carry 1, 0 steps", function () {
        let sq = 1; 
        let result = day3.steps(sq);
        expect(result).to.equal(0);
    });

    it("should carry 12, 3 steps", function () {
        let sq = 12; 
        let result = day3.steps(sq);
        expect(result).to.equal(3);
    });

    it("should carry 49, 6 steps", function () {
        let sq = 49; 
        let result = day3.steps(sq);
        expect(result).to.equal(6);
    });

    it("should carry 1024, 31 steps", function () {
        let sq = 1024; 
        let result = day3.steps(sq);
        expect(result).to.equal(31);
    });
    
    // it("Day 3, Part 1", function () {
    //     let sq = 312051; 
    //     let result = day3.steps(sq);
    //     console.log(result);
    // });
});

describe("Day 3, Part 2, first value larger than", function () {
    it("15 should return 23", function () {
        let value = 15; 
        let result = day3.firstValueLargerThan(value);
        expect(result).to.equal(23);
    });

    it("355 should return 362", function () {
        let value = 355; 
        let result = day3.firstValueLargerThan(value);
        expect(result).to.equal(362);
    });
    
    // it("Day 3, Part 2", function () {
    //     let val = 312051; 
    //     let result = day3.firstValueLargerThan(val);
    //     console.log(result);
    // });
});
