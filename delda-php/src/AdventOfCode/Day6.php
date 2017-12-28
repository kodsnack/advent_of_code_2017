<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day6 extends AbstractAdventOfCode
{
    protected $class = 6;

    public function firstPart(): string
    {
        return sizeof($this->memoryReallocation()) - 1;
    }

    public function secondPart(): string
    {
        $solution = $this->memoryReallocation();
        return (sizeof($solution) - 1) - current(array_keys($solution, end($solution)));
    }

    private function memoryReallocation(): array
    {
        $memoryBanks = explode("\t", $this->input);
        $sizeOfMemoryBanks = sizeof($memoryBanks);
        $savedStates = [];

        while (!in_array($memoryBanks, $savedStates)) {
            $savedStates[] = $memoryBanks;
            $bloks = max($memoryBanks);
            $bankIdx = current(array_keys($memoryBanks, $bloks));
            $memoryBanks[$bankIdx] = 0;
            $i = 1;
            while ($bloks > 0) {
                $memoryBanks[($bankIdx+$i)%$sizeOfMemoryBanks]++;
                $bloks--;
                $i++;
            }
        }
        $savedStates[] = $memoryBanks;

        return $savedStates;
    }
}
