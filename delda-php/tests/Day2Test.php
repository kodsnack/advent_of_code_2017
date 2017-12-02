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
        $this->assertEquals(0, $aoc->firstPart());
    }

//    public function testSecondPartAllDigitsMatch()
//    {
//        $aoc = new Day1('1212');
//        $this->assertEquals(6, $aoc->secondPart());
//    }
//
//    public function testSecondPartNoDigitsMatch()
//    {
//        $aoc = new Day1('1221');
//        $this->assertEquals(0, $aoc->secondPart());
//    }
//
//    public function testSecondPartOnly2dMatches()
//    {
//        $aoc = new Day1('123425');
//        $this->assertEquals(4, $aoc->secondPart());
//    }
//
//    public function testSecondPartAllDigitsMatchExtended()
//    {
//        $aoc = new Day1('123123');
//        $this->assertEquals(12, $aoc->secondPart());
//    }
//
//    public function testSecondPartLastExample()
//    {
//        $aoc = new Day1('12131415');
//        $this->assertEquals(4, $aoc->secondPart());
//    }
//
//    public function testSecondPartSolution()
//    {
//        $aoc = new Day1(file_get_contents(__DIR__.'/../src/Resources/Day1Input'));
//        $this->assertEquals(1188, $aoc->secondPart());
//    }
}
