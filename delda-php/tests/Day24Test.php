<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day24;

class Day24Test extends TestCase
{
    private $test = '0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10';

    public function testFirstPartExample()
    {
        $aoc = new Day24($this->test);
        $this->assertEquals(31, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day24();
        $this->assertEquals(1940, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day24($this->test);
        $this->assertEquals(19, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day24();
        $this->assertEquals(1928, $aoc->secondPart());
    }
}
