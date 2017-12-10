let hash = require('../day10');
let expect = require('chai').expect;

describe('Day 10, part 1 - hash', function () {
    it('should return 12', function () {
        let input = '3, 4, 1, 5';
        let result = hash.calculate(input, 5);
        expect(result).to.equal(12);
    });
    
    it('Result', function () {
        let input = '63, 144, 180, 149, 1, 255, 167, 84, 125, 65, 188, 0, 2, 254, 229, 24';
        let result = hash.calculate(input, 256);
        console.log('Result day 10, part 1: ' + result);
    });
});
