<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day3;

class Day3Test extends TestCase
{
    public function testFirstPartSquare1()
    {
        $aoc = new Day3('1');
        $this->assertEquals(0, $aoc->firstPart());
    }

    public function testFirstPartSquare12()
    {
        $aoc = new Day3('12');
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartSquare23()
    {
        $aoc = new Day3('23');
        $this->assertEquals(2, $aoc->firstPart());
    }

    public function testFirstPartSquare1024()
    {
        $aoc = new Day3('1024');
        $this->assertEquals(31, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day3();
        $this->assertEquals(371, $aoc->firstPart());
    }

    public function testSecondPartLargestThan2()
    {
        $aoc = new Day3('2');
        $this->assertEquals(4, $aoc->secondPart());
    }

    public function testSecondPartLargestThan10()
    {
        $aoc = new Day3('10');
        $this->assertEquals(11, $aoc->secondPart());
    }

    public function testSecondPartLargestThan54()
    {
        $aoc = new Day3('54');
        $this->assertEquals(57, $aoc->secondPart());
    }

    public function testSecondPartLargestThan304()
    {
        $aoc = new Day3('304');
        $this->assertEquals(330, $aoc->secondPart());
    }

    public function testSecondPartLargestThan806()
    {
        $aoc = new Day3('806');
        $this->assertEquals(880, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day3();
        $this->assertEquals(369601, $aoc->secondPart());
    }
}
