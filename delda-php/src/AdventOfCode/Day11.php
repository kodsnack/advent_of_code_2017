<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day11 extends AbstractAdventOfCode
{
    protected $class = 11;

    public function firstPart(): string
    {
        $steps = explode(',', $this->input);
        $x = $y = 0;
        foreach ($steps as $step) {
            list($x, $y) = $this->setStep($step, $x, $y);
        }

        return $this->hexDistance([$x,$y]);
    }

    public function secondPart(): string
    {
        $steps = explode(',', $this->input);
        $x = $y = 0;
        $max = 0;
        foreach ($steps as $step) {
            list($x, $y) = $this->setStep($step, $x, $y);
            $max = max($max, $this->hexDistance([$x,$y]));
        }

        return $max;
    }

    private function setStep(string $command, int $x, int $y): array
    {
        // https://www.redblobgames.com/grids/hexagons/#coordinates-offset
        // “even-q” vertical layout
        switch ($command) {
            case 'nw':
                $y += ($x % 2 == 0) ? 0 : 1;
                $x--;
                break;
            case 'n':
                $y++;
                break;
            case 'ne':
                $y += ($x % 2 == 0) ? 0 : 1;
                $x++;
                break;
            case 'se':
                $y -= ($x % 2 == 0) ? 1 : 0;
                $x++;
                break;
            case 's':
                $y--;
                break;
            case 'sw':
                $y -= ($x % 2 == 0) ? 1 : 0;
                $x--;
                break;
        }

        return [$x, $y];
    }

    private function hexDistance(array $a): int
    {
        return abs($a[0]) + max(abs($a[1]) - floor((abs($a[0]) + ($a[1] >= 0 ? 0 : $a[0] % 2 === 0 ? 0 : 1)) / 2), 0);
    }
}
