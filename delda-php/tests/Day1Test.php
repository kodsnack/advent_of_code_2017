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
        $aoc = new Day1(file_get_contents(__DIR__.'/../src/Resources/Day1Input'));
        $this->assertEquals(0, $aoc->firstPart());
    }
}
