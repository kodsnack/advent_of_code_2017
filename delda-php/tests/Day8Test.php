<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day8;

class Day8Test extends TestCase
{
    private $testExample =
"b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10";

    public function testFirstPartExample()
    {
        $aoc = new Day8($this->testExample);
        $this->assertEquals(1, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day8();
        $this->assertEquals(3089, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day8($this->testExample);
        $this->assertEquals(10, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day8();
        $this->assertEquals(5391, $aoc->secondPart());
    }
}
