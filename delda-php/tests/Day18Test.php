<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day18;

class Day18Test extends TestCase
{
    private $test =
        'set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2';

    public function testFirstPartExample()
    {
        $aoc = new Day18($this->test);
        $this->assertEquals(4, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day18();
        $this->assertEquals(2951, $aoc->firstPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day18();
        $this->assertEquals(7366, $aoc->secondPart());
    }
}
