<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day14;

class Day14Test extends TestCase
{
    public function testFirstPartHex2Bin()
    {
        $aoc = new Day14();
        $this->assertEquals('10100000110000100000000101110000', $aoc->binaryRappresentation('a0c20170'));
    }

    public function testFirstPartExample1()
    {
        $aoc14 = new Day14('flqrgnkx-0');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('11010100', substr($bits, 0, 8));
    }

    public function testFirstPartExample2()
    {
        $aoc14 = new Day14('flqrgnkx-1');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('01010101', substr($bits, 0, 8));
    }

    public function testFirstPartExample3()
    {
        $aoc14 = new Day14('flqrgnkx-2');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('00001010', substr($bits, 0, 8));
    }

    public function testFirstPartExample4()
    {
        $aoc14 = new Day14('flqrgnkx-3');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('10101101', substr($bits, 0, 8));
    }

    public function testFirstPartExample5()
    {
        $aoc14 = new Day14('flqrgnkx-4');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('01101000', substr($bits, 0, 8));
    }

    public function testFirstPartExample6()
    {
        $aoc14 = new Day14('flqrgnkx-5');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('11001001', substr($bits, 0, 8));
    }

    public function testFirstPartExample7()
    {
        $aoc14 = new Day14('flqrgnkx-6');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('01000100', substr($bits, 0, 8));
    }

    public function testFirstPartExample8()
    {
        $aoc14 = new Day14('flqrgnkx-7');
        $knotHashes = $aoc14->getKnotHashes();
        $bits = $aoc14->binaryRappresentation($knotHashes);
        $this->assertEquals('11010110', substr($bits, 0, 8));
    }

    public function testFirstPartSolutionExample()
    {
        $aoc = new Day14('flqrgnkx');
        $this->assertEquals(8108, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day14();
        $this->assertEquals(8214, $aoc->firstPart());
    }

    public function testSecondPartSolutionExample()
    {
        $aoc = new Day14('flqrgnkx');
        $this->assertEquals(1242, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day14();
        $this->assertEquals(1093, $aoc->secondPart());
    }
}
