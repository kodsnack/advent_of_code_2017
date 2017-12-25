<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day7;

class Day7Test extends TestCase
{
    private $testExample =
"pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)";

    public function testFirstPartExample()
    {
        $aoc = new Day7($this->testExample);
        $this->assertEquals('tknk', $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day7();
        $this->assertEquals('gmcrj', $aoc->firstPart());
    }
}
