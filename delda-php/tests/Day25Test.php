<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day25;

class Day25Test extends TestCase
{
    private $test = 'Begin in state A.
Perform a diagnostic checksum after 6 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.';

    public function testFirstPartExample()
    {
        $aoc = new Day25($this->test);
        $this->assertEquals(3, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day25();
        $this->assertEquals(3578, $aoc->firstPart());
    }
}
