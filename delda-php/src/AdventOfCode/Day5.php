<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day5 extends AbstractAdventOfCode
{
    protected $class = 5;

    public function firstPart(): string
    {
        $steps = 0;
        $jumps = explode(PHP_EOL, $this->input);
        $offset = 0;
        while ($offset < sizeof($jumps) && ++$steps) {
            $offset += $jumps[$offset]++;
        }

        return $steps;
    }

    public function secondPart(): string
    {
        $steps = 0;
        $jumps = explode(PHP_EOL, $this->input);
        $offset = 0;
        while ($offset < sizeof($jumps) && ++$steps) {
            $nextOffset = $offset + $jumps[$offset];
            $jumps[$offset] += ($jumps[$offset] > 2) ? -1 : 1;
            $offset = $nextOffset;
        }

        return $steps;
    }
}
