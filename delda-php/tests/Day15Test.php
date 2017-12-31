<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day15;

class Day15Test extends TestCase
{
    private $testCase =
        'Generator A starts with 65
Generator B starts with 8921';

    public function testFirstPartExample()
    {
        $aoc = new Day15($this->testCase);
        $aoc->iterations = 5;
        $this->assertEquals(1, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day15();
        $this->assertEquals(638, $aoc->firstPart());
    }

    public function testSecondPartOneIterationBeforeFirstMatchExample()
    {
        $aoc = new Day15($this->testCase);
        $aoc->iterations = 1055;
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartFirstMatchExample()
    {
        $aoc = new Day15($this->testCase);
        $aoc->iterations = 1056;
        $this->assertEquals(1, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day15();
        $this->assertEquals(343, $aoc->secondPart());
    }
}
