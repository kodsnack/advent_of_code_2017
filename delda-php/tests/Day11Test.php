<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day11;

class Day11Test extends TestCase
{
    public function testFirstPartAlwaysNorthEast()
    {
        $aoc = new Day11('ne,ne,ne');
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartBackToStartPoint()
    {
        $aoc = new Day11('ne,ne,sw,sw');
        $this->assertEquals(0, $aoc->firstPart());
    }

    public function testFirstPartTwoStepsAwaySimple()
    {
        $aoc = new Day11('se,se');
        $this->assertEquals(2, $aoc->firstPart());
    }

    public function testFirstPartTwoStepsAwayComplex()
    {
        $aoc = new Day11('ne,ne,s,s');
        $this->assertEquals(2, $aoc->firstPart());
    }

    public function testFirstPartThreeStepsAwaySimple()
    {
        $aoc = new Day11('s,s,sw');
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartThreeStepsAwayComplex()
    {
        $aoc = new Day11('se,sw,se,sw,sw');
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day11();
        $this->assertEquals(685, $aoc->firstPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day11();
        $this->assertEquals(1457, $aoc->secondPart());
    }
}
