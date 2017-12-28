<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day15 extends AbstractAdventOfCode
{
    protected $class = 15;
    private $factor = ['A' => 16807, 'B' => 48271];
    private $multiples = ['A' => 4, 'B' => 8];
    private $dividing = 2147483647;
    public $iterations;

    public function firstPart(): string
    {
        $this->iterations = (empty($this->iterations)) ? 40000000 : $this->iterations;

        return $this->duelingGenerators(function ($input, $generator) {
            $input[$generator] *= $this->factor[$generator];
            $input[$generator]= $input[$generator] % $this->dividing;
            return $input;
        });
    }

    public function secondPart(): string
    {
        $this->iterations = (empty($this->iterations)) ? 5000000 : $this->iterations;

        return $this->duelingGenerators(function ($input, $generator) {
            do {
                $input[$generator] *= $this->factor[$generator];
                $input[$generator]= $input[$generator] % $this->dividing;
            } while ($input[$generator] % $this->multiples[$generator] != 0);

            return $input;
        });
    }

    private function parser(string $input): array
    {
        preg_match_all('/Generator ([A|B]) starts with (\d+)/', $input, $matches);
        for ($i = 0; $i < 2; $i++) {
            $values[$matches[1][$i]] = $matches[2][$i];
        }

        return $values;
    }

    private function duelingGenerators($function)
    {
        $judgeCount = 0;
        $input = $this->parser($this->input);
        for ($i = 0; $i < $this->iterations; $i++) {
            foreach (['A', 'B'] as $generator) {
                $input = $function($input, $generator);
                $binary[$generator] = decbin($input[$generator]);
            }
            if (substr($binary['A'], -16) == substr($binary['B'], -16)) {
                $judgeCount++;
            }
        }

        return $judgeCount;
    }
}
