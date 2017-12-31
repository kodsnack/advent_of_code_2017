<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day17;

class Day17Test extends TestCase
{
    public function testFirstPartExample()
    {
        $aoc = new Day17('3');
        $this->assertEquals(638, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day17();
        $this->assertEquals(596, $aoc->firstPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day17();
        $this->assertEquals(39051595, $aoc->secondPart());
    }
}
