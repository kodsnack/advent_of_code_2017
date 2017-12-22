<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day13;

class Day13Test extends TestCase
{
    private $test =
'0: 3
1: 2
4: 4
6: 4';

    public function testFirstPartExample()
    {
        $aoc = new Day13($this->test);
        $this->assertEquals(24, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day13();
        $this->assertEquals(748, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day13($this->test);
        $this->assertEquals(10, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day13();
        $this->assertEquals(3873662, $aoc->secondPart());
    }
}
