<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day7 extends AbstractAdventOfCode
{
    protected $class = 7;
    private $programs = [];

    public function firstPart(): string
    {
        $this->programs = $this->marshalPrograms();
        return $this->bottomProgram(key($this->programs));
    }

    public function secondPart(): string
    {
        $this->programs = $this->marshalPrograms();
        $bottomProgram = $this->bottomProgram(key($this->programs));

        return $this->findUnbalancedDisk($bottomProgram);
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
        foreach ($this->programs as $programName => $program) {
            if (is_array($program->children) && in_array($currentProgram, $program->children)) {
                return $this->bottomProgram($programName);
            }
        }

        return $currentProgram;
    }

    private function findUnbalancedDisk(string $currentProgram): string
    {
        $partialSum = null;
        if (!is_array($this->programs[$currentProgram]->children)) {
            return null;
        }

        foreach ($this->programs[$currentProgram]->children as $children) {
            $sum = $this->programs[$children]->weight;
            $sum += array_reduce(
                $this->programs[$children]->children,
                function($carry, $idx) {
                    var_dump($idx);
                    $carry += $this->programs[$idx]->weight;
                    var_dump($carry);
                    return $carry;
                },
                0
            );
            if ($partialSum == null) {
                echo 'partial sum: ', $sum, PHP_EOL;
                $partialSum = $sum;
            } elseif ($partialSum != $sum){
                echo 'partial sum: ', $sum, PHP_EOL;
            }
        }
        return $currentProgram;
    }
}
