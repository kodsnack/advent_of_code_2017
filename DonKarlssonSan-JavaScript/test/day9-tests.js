let stream = require('../day9');
let expect = require('chai').expect;

describe('Day 9, part 1 - score', function () {
    it('should return 1', function () {
        let input = '{}';
        let result = stream.process(input);
        expect(result).to.equal(1);
    });
    
    it('should return 6', function () {
        let input = '{{{}}}';
        let result = stream.process(input);
        expect(result).to.equal(6);
    });

    it('should return 5', function () {
        let input = '{{},{}}';
        let result = stream.process(input);
        expect(result).to.equal(5);
    });

    it('should return 16', function () {
        let input = '{{{},{},{{}}}}';
        let result = stream.process(input);
        expect(result).to.equal(16);
    });
    
    it('should return 1', function () {
        let input = '{<a>,<a>,<a>,<a>}';
        let result = stream.process(input);
        expect(result).to.equal(1);
    });

    it('should return 9', function () {
        let input = '{{<ab>},{<ab>},{<ab>},{<ab>}}';
        let result = stream.process(input);
        expect(result).to.equal(9);
    });
    
    it('should return 9', function () {
        let input = '{{<!!>},{<!!>},{<!!>},{<!!>}}';
        let result = stream.process(input);
        expect(result).to.equal(9);
    });
    
    it('should return 3', function () {
        let input = '{{<a!>},{<a!>},{<a!>},{<ab>}}';
        let result = stream.process(input);
        expect(result).to.equal(3);
    });

    // it("Result part 1", function () {
    //     const inputFile = "../day9-input.txt"; 
    //     const path = require("path");
    //     const filepath = path.join(__dirname, inputFile);
    //     const fs = require('fs');
    //     const input = fs.readFileSync(filepath, 'utf8');
    //     const score = stream.process(input);
    //     console.log(score);
    // });

});

describe('Day 9, part 2 - garbage counter', function () {
    it('should return 17', function () {
        let input = '<random characters>';
        let result = stream.countGarbage(input);
        expect(result).to.equal(17);
    });

    it('should return 0', function () {
        let input = '<!!!>>';
        let result = stream.countGarbage(input);
        expect(result).to.equal(0);
    });
    
    it('should return 10', function () {
        let input = '<{o"i!a,<{i<a>';
        let result = stream.countGarbage(input);
        expect(result).to.equal(10);
    });

    // it("Result part 2", function () {
    //     const inputFile = "../day9-input.txt"; 
    //     const path = require("path");
    //     const filepath = path.join(__dirname, inputFile);
    //     const fs = require('fs');
    //     const input = fs.readFileSync(filepath, 'utf8');
    //     const result = stream.countGarbage(input);
    //     console.log(result);
    // });
});