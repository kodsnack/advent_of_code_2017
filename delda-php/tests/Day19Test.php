<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day19;

class Day19Test extends TestCase
{
    private $test =
        '     |          
     |  +--+    
     A  |  C    
 F---|----E|--+ 
     |  |  |  D 
     +B-+  +--+ 
                
';

    public function testFirstPartExample()
    {
        $aoc = new Day19($this->test);
        $this->assertEquals('ABCDEF', $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day19();
        $this->assertEquals('BPDKCZWHGT', $aoc->firstPart());
    }

    public function testSecondPartExample()
    {
        $aoc = new Day19($this->test);
        $this->assertEquals(38, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day19();
        $this->assertEquals(17728, $aoc->secondPart());
    }
}
