<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day21;

class Day21Test extends TestCase
{
    private $test = '../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#';

    public function testFirstPartExample()
    {
        $aoc = new Day21($this->test);
        $aoc->iteration = 2;
        $this->assertEquals(12, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day21();
        $aoc->iteration = 5;
        $this->assertEquals(188, $aoc->firstPart());
    }

    // too much long time test
//    public function testSecondPartSolution()
//    {
//        $aoc = new Day21();
//        $this->assertEquals(2758764, $aoc->secondPart());
//    }
}
