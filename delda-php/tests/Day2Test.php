<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day2;

class Day2Test extends TestCase
{
    public function testFirstPartUniqueExample()
    {
        $aoc = new Day2("5\t1\t9\t5\n7\t5\t3\n2\t4\t6\t8");
        $this->assertEquals(18, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day2();
        $this->assertEquals(32020, $aoc->firstPart());
    }

    public function testSecondPartUniqueExample()
    {
        $aoc = new Day2("5\t9\t2\t8\n9\t4\t7\t3\n3\t8\t6\t5");
        $this->assertEquals(9, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day2();
        $this->assertEquals(236, $aoc->secondPart());
    }
}
