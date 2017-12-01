<?php

namespace src\AdventOfCode;

class Day1 extends AbstractAdventOfCode
{
    public function __construct($input)
    {
        $this->input = $input;
    }

    public function firstPart(): string
    {
        $sizeOfInput = strlen($this->input);
        $input = $this->input;
        $sum = 0;

        for ($i = 0; $i < $sizeOfInput; $i++) {
            if ($input[$i] == $input[($i+1)%$sizeOfInput]) {
                $sum += $input[$i];
            }
        }

        return $sum;
    }

    public function secondPart(): string
    {
       return '';
    }
}