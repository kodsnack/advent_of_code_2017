<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day12;

class Day12Test extends TestCase
{
    private $test = '0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5';

    public function testFirstPartExample()
    {
        $aoc = new Day12($this->test);
        $this->assertEquals(6, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day12();
        $this->assertEquals(115, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day12($this->test);
        $this->assertEquals(2, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day12();
        $this->assertEquals(221, $aoc->secondPart());
    }
}
