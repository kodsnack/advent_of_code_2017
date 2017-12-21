<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day9;

class Day9Test extends TestCase
{
    public function testFirstPartOneGroup()
    {
        $aoc = new Day9('{}');
        $this->assertEquals(1, $aoc->firstPart());
    }

    public function testFirstPartThreeGroupsNested()
    {
        $aoc = new Day9('{{{}}}');
        $this->assertEquals(6, $aoc->firstPart());
    }

    public function testFirstPartThreeGroups()
    {
        $aoc = new Day9('{{},{}}');
        $this->assertEquals(5, $aoc->firstPart());
    }

    public function testFirstPartSixGroups()
    {
        $aoc = new Day9('{{{},{},{{}}}}');
        $this->assertEquals(16, $aoc->firstPart());
    }

    public function testFirstPartOneGroupWithGarbages()
    {
        $aoc = new Day9('{<a>,<a>,<a>,<a>}');
        $this->assertEquals(1, $aoc->firstPart());
    }

    public function testFirstPartNestedGroupsWithGarbages()
    {
        $aoc = new Day9('{{<ab>},{<ab>},{<ab>},{<ab>}}');
        $this->assertEquals(9, $aoc->firstPart());
    }

    public function testFirstPartNestedGroupsWithIngoredOption()
    {
        $aoc = new Day9('{{<!!>},{<!!>},{<!!>},{<!!>}}');
        $this->assertEquals(9, $aoc->firstPart());
    }

    public function testFirstPartIgnoreCharacter()
    {
        $aoc = new Day9('{{<a!>},{<a!>},{<a!>},{<ab>}}');
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day9();
        $this->assertEquals(9662, $aoc->firstPart());
    }

    public function testSecondPartNoGarbage()
    {
        $aoc = new Day9('<>');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartMoreGarbageCharacters()
    {
        $aoc = new Day9('<random characters>');
        $this->assertEquals(17, $aoc->secondPart());
    }

    public function testSecondPartMultipleLessThan()
    {
        $aoc = new Day9('<<<<>');
        $this->assertEquals(3, $aoc->secondPart());
    }

    public function testSecondPartOneExclamation()
    {
        $aoc = new Day9('<{!>}>');
        $this->assertEquals(2, $aoc->secondPart());
    }

    public function testSecondPartTwoExclamation()
    {
        $aoc = new Day9('<!!>');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartMoreExclamation()
    {
        $aoc = new Day9('<!!!>>');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartAllOptions()
    {
        $aoc = new Day9('<{o"i!a,<{i<a>');
        $this->assertEquals(10, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day9();
        $this->assertEquals(4903, $aoc->secondPart());
    }
}
