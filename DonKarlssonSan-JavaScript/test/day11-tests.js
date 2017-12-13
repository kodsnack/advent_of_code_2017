const hex = require('../day11');
const expect = require('chai').expect;

describe('Day 11, part 1 - hex', function () {
    it('should return three steps for ne,ne,ne', function () {
        let input = 'ne,ne,ne';
        let result = hex.walk(input)[0];
        expect(result).to.equal(3);
    });

    it('should return zero steps for ne,ne,sw,sw', function () {
        let input = 'ne,ne,sw,sw';
        let result = hex.walk(input)[0];
        expect(result).to.equal(0);
    });

    it('should return two steps for ne,ne,s,s', function () {
        let input = 'ne,ne,s,s';
        let result = hex.walk(input)[0];
        expect(result).to.equal(2);
    });
    
    it('should return one steps for ne', function () {
        let input = 'ne';
        let result = hex.walk(input)[0];
        expect(result).to.equal(1);
    });
    
    it('should return two steps for ne,n', function () {
        let input = 'ne,n';
        let result = hex.walk(input)[0];
        expect(result).to.equal(2);
    });

    it('should return one steps for ne,s', function () {
        let input = 'ne,s';
        let result = hex.walk(input)[0];
        expect(result).to.equal(1);
    });

    it('should return three steps for ne,ne,ne,s', function () {
        let input = 'ne,ne,ne,s';
        let result = hex.walk(input)[0];
        expect(result).to.equal(3);
    });

    it("Result part 1 and 2", function () {
        const inputFile = "../day11-input.txt"; 
        const path = require("path");
        const filepath = path.join(__dirname, inputFile);
        const fs = require('fs');
        const input = fs.readFileSync(filepath, 'utf8');
        const result = hex.walk(input);
        const steps = result[0];
        const maxSteps = result[1];
        console.log('Steps: ' + steps, 'Max steps: ' + maxSteps);
    });
});
