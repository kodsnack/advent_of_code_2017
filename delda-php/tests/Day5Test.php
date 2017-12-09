<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day5;

class Day5Test extends TestCase
{
    public function testFirstPartExample()
    {
        $aoc = new Day5("0\n3\n0\n1\n-3");
        $this->assertEquals(5, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day5();
        $this->assertEquals(326618, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day5("0\n3\n0\n1\n-3");
        $this->assertEquals(10, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day5();
        $this->assertEquals(21841249, $aoc->secondPart());
    }
}
