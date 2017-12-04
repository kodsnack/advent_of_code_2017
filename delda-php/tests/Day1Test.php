<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day1;

class Day1Test extends TestCase
{
    public function testFirstPartBaseExample()
    {
        $aoc = new Day1('1122');
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartAllDigitSameValue()
    {
        $aoc = new Day1('1111');
        $this->assertEquals(4, $aoc->firstPart());
    }

    public function testFirstPartNoDigitMatchesNextValue()
    {
        $aoc = new Day1('1234');
        $this->assertEquals(0, $aoc->firstPart());
    }

    public function testFirstPartOnlyLastDigitMatches()
    {
        $aoc = new Day1('91212129');
        $this->assertEquals(9, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day1();
        $this->assertEquals(1097, $aoc->firstPart());
    }

    public function testSecondPartAllDigitsMatch()
    {
        $aoc = new Day1('1212');
        $this->assertEquals(6, $aoc->secondPart());
    }

    public function testSecondPartNoDigitsMatch()
    {
        $aoc = new Day1('1221');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartOnly2dMatches()
    {
        $aoc = new Day1('123425');
        $this->assertEquals(4, $aoc->secondPart());
    }

    public function testSecondPartAllDigitsMatchExtended()
    {
        $aoc = new Day1('123123');
        $this->assertEquals(12, $aoc->secondPart());
    }

    public function testSecondPartLastExample()
    {
        $aoc = new Day1('12131415');
        $this->assertEquals(4, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day1();
        $this->assertEquals(1188, $aoc->secondPart());
    }
}
