<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day17 extends AbstractAdventOfCode
{
    protected $class = 17;
    public $steps = 2017;

    public function firstPart(): string
    {
        $programs = $this->spinlock([0]);
        $idx = array_search('2017', $programs);

        return $programs[$idx+1];
    }

    public function secondPart(): string
    {
        $this->steps = 50000000;

        return $this->angrySpinlock();
    }

    private function spinlock(array $programs): array
    {
        $idx = $currentIdx = 0;
        for ($step = 1; $step <= $this->steps; $step++) {
            $idx = $this->input % sizeof($programs);
            $idx = ($idx + $currentIdx) % sizeof($programs) + 1;
            $currentIdx = $idx;
            array_splice($programs, $idx, 0, $step);
        }

        return $programs;
    }

    private function angrySpinlock()
    {
        $idx = 0;
        $currentIdx = 0;
        for ($value = 1; $value <= $this->steps; $value++) {
            $idx = ($idx + $this->input) % $value;
            if ($idx == 0) {
                $currentIdx = $value;
            }
            $idx = ($idx + 1) % ($value + 1);
        }

        return $currentIdx;
    }
}
