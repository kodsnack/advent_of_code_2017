const graph = require('../day12');
const expect = require('chai').expect;

describe('Day 12, part 1 - graph', function () {

    it('should return a graph with three vertices', function () {
        let input = 
`0 <-> 2
2 <-> 6`;
        let g = graph.buildGraph(input);
        expect(g.size).to.equal(3);
    });

    it('should return a graph with one vertex', function () {
        let input = '1 <-> 1';
        let g = graph.buildGraph(input);
        expect(g.size).to.equal(1);
    });

    it('should return a graph with four vertices', function () {
        let input = '2 <-> 0, 3, 4';
        let g = graph.buildGraph(input);
        expect(g.size).to.equal(4);
    });

    it('should return two vertices in connected component for 0', function () {
        let input = '0 <-> 2';
        let result = graph.nrOfVerticesInCcFor('0', input);
        expect(result).to.equal(2);
    });

    it('should return six vertices in connected component for 0', function () {
        let input = 
`0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5`;
        let result = graph.nrOfVerticesInCcFor('0', input);
        expect(result).to.equal(6);
    });

    it("Result part 1", function () {
        const inputFile = "../day12-input.txt"; 
        const path = require("path");
        const filepath = path.join(__dirname, inputFile);
        const fs = require('fs');
        const input = fs.readFileSync(filepath, 'utf8');
        const result = graph.nrOfVerticesInCcFor('0', input);
        console.log(result);
    });
});


describe('Day 12, part 2 - connected components', function () {
    
    it('should return one connected component', function () {
        let input = `1 <-> 1`;
        let result = graph.nrOfConnectedComponents(input);
        expect(result).to.equal(1);
    });

    it('should return two connected components', function () {
        let input = 
`1 <-> 1
2 <-> 2`;
        let result = graph.nrOfConnectedComponents(input);
        expect(result).to.equal(2);
    });

    it('should return two connected components, whole example input', function () {
        let input = 
`0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5`;
        let result = graph.nrOfConnectedComponents(input);
        expect(result).to.equal(2);
    });

    it("Result part 2", function () {
        const inputFile = "../day12-input.txt"; 
        const path = require("path");
        const filepath = path.join(__dirname, inputFile);
        const fs = require('fs');
        const input = fs.readFileSync(filepath, 'utf8');
        const result = graph.nrOfConnectedComponents(input);
        console.log(result);
    });
});
