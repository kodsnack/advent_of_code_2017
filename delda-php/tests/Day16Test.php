<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day16;

class Day16Test extends TestCase
{
    public function testFirstPartSpin()
    {
        $aoc = new Day16('s1');
        $aoc->programs = str_split('abcde');
        ;
        $this->assertEquals('eabcd', $aoc->firstPart());
    }

    public function testFirstPartExchange()
    {
        $aoc = new Day16('x3/4');
        $aoc->programs = str_split('eabcd');
        $this->assertEquals('eabdc', $aoc->firstPart());
    }

    public function testFirstPartPartner()
    {
        $aoc = new Day16('pe/b');
        $aoc->programs = str_split('eabdc');
        $this->assertEquals('baedc', $aoc->firstPart());
    }

    public function testFirstPartExample()
    {
        $aoc = new Day16('s1,x3/4,pe/b');
        $aoc->programs = str_split('abcde');
        $this->assertEquals('baedc', $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day16();
        $this->assertEquals('padheomkgjfnblic', $aoc->firstPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day16();
        $this->assertEquals('bfcdeakhijmlgopn', $aoc->secondPart());
    }
}
