<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day20;

class Day20Test extends TestCase
{
    private $test1 = 'p=<3,0,0>, v=<2,0,0>, a=<-1,0,0>
p=<4,0,0>, v=<0,0,0>, a=<-2,0,0> ';
    private $test2 = 'p=<-6,0,0>, v=<3,0,0>, a=<0,0,0>    
p=<-4,0,0>, v=<2,0,0>, a=<0,0,0>
p=<-2,0,0>, v=<1,0,0>, a=<0,0,0>
p=<3,0,0>, v=<-1,0,0>, a=<0,0,0>';

    public function testFirstPartExample()
    {
        $aoc = new Day20($this->test1);
        $this->assertEquals(0, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day20();
        $this->assertEquals(144, $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day20($this->test2);
        $this->assertEquals(1, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day20();
        $this->assertEquals(477, $aoc->secondPart());
    }
}
