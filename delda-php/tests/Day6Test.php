<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day6;

class Day6Test extends TestCase
{
    public function testFirstPartExample()
    {
        $aoc = new Day6("0\t2\t7\t0");
        $this->assertEquals(5, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day6();
        $this->assertEquals(4074, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day6("0\t2\t7\t0");
        $this->assertEquals(4, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day6();
        $this->assertEquals(2793, $aoc->secondPart());
    }
}
