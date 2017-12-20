<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day10;

class Day10Test extends TestCase
{
    public function testFirstPartExample()
    {
        $aoc = new Day10('3,4,1,5', 4);
        $this->assertEquals(12, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day10();
        $this->assertEquals(13760, $aoc->firstPart());
    }

    public function testSecondPartStringOfBytes()
    {
        $aoc = new Day10();
        $this->assertEquals([49,44,50,44,51,17,31,73,47,23], $aoc->stringOfBytes('1,2,3'));
    }

    public function testSecondPartXorOperator()
    {
        $aoc = new Day10();
        $this->assertEquals(64, $aoc->xorOperator([65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22]));
    }

    public function testSecondPartEmptyString()
    {
        $aoc = new Day10('');
        $this->assertEquals('a2582a3a0e66e6e86e3812dcb672a272', $aoc->secondPart());
    }

    public function testSecondPartNotEmptyString()
    {
        $aoc = new Day10('AoC 2017');
        $this->assertEquals('33efeb34ea91902bb2f59c9920caa6cd', $aoc->secondPart());
    }

    public function testSecondPartSequance1()
    {
        $aoc = new Day10('1,2,3');
        $this->assertEquals('3efbe78a8d82f29979031a4aa0b16a9d', $aoc->secondPart());
    }

    public function testSecondPartSequance2()
    {
        $aoc = new Day10('1,2,4');
        $this->assertEquals('63960835bcdc130f0b66d7ff4f6a5a8e', $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day10();
        $this->assertEquals('2da93395f1a6bb3472203252e3b17fe5', $aoc->secondPart());
    }
}
