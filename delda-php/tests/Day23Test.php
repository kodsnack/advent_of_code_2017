<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day23;

class Day23Test extends TestCase
{
    public function testFirstPartSolution()
    {
        $aoc = new Day23();
        $this->assertEquals(6241, $aoc->firstPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day23();
        $this->assertEquals(909, $aoc->secondPart());
    }
}
