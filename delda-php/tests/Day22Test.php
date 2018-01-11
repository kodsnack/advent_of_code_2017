<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day22;

class Day22Test extends TestCase
{
    private $test = '..#
#..
...';

    public function testFirstPartExample()
    {
        $aoc = new Day22($this->test);
        $aoc->burstsOfActivity = 7;
        $this->assertEquals(5, $aoc->firstPart());
    }

    public function testFirstPartExampleExtended()
    {
        $aoc = new Day22($this->test);
        $aoc->burstsOfActivity = 70;
        $this->assertEquals(41, $aoc->firstPart());
    }

    public function testFirstPartExampleComplete()
    {
        $aoc = new Day22($this->test);
        $this->assertEquals(5587, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day22();
        $aoc->burstsOfActivity = 10000;
        $this->assertEquals(5447, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day22($this->test);
        $aoc->burstsOfActivity = 100;
        $this->assertEquals(26, $aoc->secondPart());
    }

    public function testSecondPartExampleComplete()
    {
        $aoc = new Day22($this->test);
        $aoc->burstsOfActivity = 10000000;
        $this->assertEquals(2511944, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day22();
        $aoc->burstsOfActivity = 10000000;
        $this->assertEquals(2511705, $aoc->secondPart());
    }
}
