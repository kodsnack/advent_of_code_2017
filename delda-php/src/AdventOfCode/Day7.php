<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day7 extends AbstractAdventOfCode
{
    protected $class = 7;
    private $tower = [];

    public function firstPart(): string
    {
        $this->tower = $this->marshalPrograms();
        return $this->bottomProgram(key($this->tower));
    }

    public function secondPart(): string
    {
        $rootProgram = $this->firstPart();
        return $this->balancedDisk($rootProgram);
    }

    private function marshalPrograms(): array
    {
        $programs = [];
        foreach (explode(PHP_EOL, $this->input) as $line) {
            @list($nameSection, $children) = explode('-> ', $line);
            preg_match('/(\w+) \((\d+)\)/', $nameSection, $matches);

            $obj = new \stdClass();
            $obj->weight = $matches[2];
            $obj->children = $children ? explode(', ', $children) : null;
            $programs[$matches[1]] = $obj;
        }

        return $programs;
    }

    private function bottomProgram(string $currentProgram): string
    {
        foreach ($this->tower as $programName => $program) {
            if (is_array($program->children) && in_array($currentProgram, $program->children)) {
                return $this->bottomProgram($programName);
            }
        }

        return $currentProgram;
    }

    private function balancedDisk(string $currentProgram): string
    {
        $prevWeight = 0;
        $partialSum = [];
        $partialSumChildren = [];
        while(true) {
            foreach ($this->tower[$currentProgram]->children as $children) {
                $sum = $this->tower[$children]->weight;
                if (isset($this->tower[$children]->children)) {
                    $partialSumChildren[$children] = array_reduce(
                        $this->tower[$children]->children,
                        function ($carry, $idx) {
                            $carry += $this->tower[$idx]->weight;
                            return $carry;
                        },
                        0
                    );
                    $partialSum[$children] = $sum + $partialSumChildren[$children];
                }
            }

            $checkUnbalanceValues = array_count_values($partialSum);
            if (sizeof($checkUnbalanceValues) > 1) {
                $uniqueValue = array_search(1, $checkUnbalanceValues);
                $multipleValues = array_unique(array_diff_assoc($partialSum, array_unique($partialSum)));
                $programToUpdate = (array_search($uniqueValue, $partialSum));

                $prevWeight = (current($multipleValues) - $partialSumChildren[array_search($uniqueValue, $partialSum)]);
                $this->tower[$programToUpdate]->weight = $prevWeight;
                $currentProgram = key($multipleValues);
            } else {
                return $prevWeight - sizeof($checkUnbalanceValues);
            }
        }
    }
}