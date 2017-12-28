<?php

require_once 'vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use src\AdventOfCode\Day4;

class Day4Test extends TestCase
{
    public function testFirstPartFiveWordsValid()
    {
        $aoc = new Day4('aa bb cc dd ee');
        $this->assertEquals(1, $aoc->firstPart());
    }

    public function testFirstPartFiveWordsNotValid()
    {
        $aoc = new Day4('aa bb cc dd aa');
        $this->assertEquals(0, $aoc->firstPart());
    }

    public function testFirstPartSimilWords()
    {
        $aoc = new Day4('aa bb cc dd aaa');
        $this->assertEquals(1, $aoc->firstPart());
    }

    public function testFirstPartSolution()
    {
        $aoc = new Day4();
        $this->assertEquals(477, $aoc->firstPart());
    }

    public function testSecondPartSimpleValidPassphrase()
    {
        $aoc = new Day4('abcde fghij');
        $this->assertEquals(1, $aoc->secondPart());
    }

    public function testSecondPartTwoWordsRearranged()
    {
        $aoc = new Day4('abcde xyz ecdab');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartValidPassphrase()
    {
        $aoc = new Day4('a ab abc abd abf abj');
        $this->assertEquals(1, $aoc->secondPart());
    }

    public function testSecondPartBinaryWords()
    {
        $aoc = new Day4('iiii oiii ooii oooi oooo');
        $this->assertEquals(1, $aoc->secondPart());
    }

    public function testSecondPartMoreRearrangedWords()
    {
        $aoc = new Day4('oiii ioii iioi iiio');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartAllPhrasesInOneTest()
    {
        $phrases ="abcde fghij\nabcde xyz ecdab\na ab abc abd abf abj\niiii oiii ooii oooi oooo\noiii ioii iioi iiio";
        $aoc = new Day4($phrases);
        $this->assertEquals(3, $aoc->secondPart());
    }

    public function testSecondPartDuplicateWord()
    {
        $aoc = new Day4('qff qff sde ryv');
        $this->assertEquals(0, $aoc->secondPart());
    }

    public function testSecondPartOnePhraseOfInputWithoutRearrangedWord()
    {
        $aoc = new Day4('xajf eyasx rupsyqx wubjwx bsrqi ripghci sbzxp sbz dhooax');
        $this->assertEquals(1, $aoc->secondPart());
    }

    public function testSecondPartSolution()
    {
        $aoc = new Day4();
        $this->assertEquals(167, $aoc->secondPart());
    }
}
