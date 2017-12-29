<?php

namespace src\AdventOfCode;

class Day1 extends AbstractAdventOfCode
{
    protected $class = 1;

    public function firstPart(): string
    {
        return $this->parser(1);
    }

    public function secondPart(): string
    {
        return $this->parser(strlen($this->input)/2);
    }

    private function parser(int $step): string
    {
        $sizeOfInput = strlen($this->input);
        $input = $this->input;
        $sum = 0;

        for ($i = 0; $i < $sizeOfInput; $i++) {
            if ($input[$i] == $input[($i+$step)%$sizeOfInput]) {
                $sum += $input[$i];
            }
        }

        return $sum;
    }
}
