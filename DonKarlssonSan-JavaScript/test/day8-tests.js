let Registers = require('../day8');
let expect = require('chai').expect;

describe('Day 8, Part 1 - evaluate', function () {
    it('should return false', function () {
        let registers = new Registers();
        let input = 'b inc 5 if a > 1';
        let result = registers.evaluate(input);
        expect(result).to.be.false;
    });
    it('should return true', function () {
        let registers = new Registers();
        let input = 'a inc 1 if b < 5';
        let result = registers.evaluate(input);
        expect(result).to.be.true;
    });
});

describe('Day 8, Part 1 - register', function () {
    it('should return 0 since no register is modified', function () {
        let reg = new Registers();
        let input = 'b inc 5 if a > 1';
        let highest = reg.processAndReturnHighestRegister(input);
        expect(highest).to.equal(0);
    });

    it('should return 1 since a is modified', function () {
        let reg = new Registers();
        let input = 'a inc 1 if b < 5';
        let highest = reg.processAndReturnHighestRegister(input);
        expect(highest).to.equal(1);
    });

    it('should return 1', function () {
        let reg = new Registers();
        let input = 
`b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10`;
        let highest = reg.processAndReturnHighestRegister(input);
        expect(highest).to.equal(1);
    });

    // it("Result", function () {
    //     const inputFile = "../day9-input.txt"; 
    //     const path = require("path");
    //     const filepath = path.join(__dirname, inputFile);
    //     const fs = require('fs');
    //     const input = fs.readFileSync(filepath, 'utf8');
    //     const reg = new Registers();
    //     const highest = reg.processAndReturnHighestRegister(input);
    //     console.log(highest);
    // });
});

