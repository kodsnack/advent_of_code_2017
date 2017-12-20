<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day9 extends AbstractAdventOfCode
{
    protected $class = 9;

    public function firstPart(): string
    {
        $stream = $this->input;
        $scores = [];
        $nest = 0;
        $garbage = false;
        for ($i = 0; $i < strlen($stream); $i++) {
            switch ($stream[$i]) {
                case '{':
                    if (!$garbage) {
                        $scores[] = ++$nest;
                    }
                    break;
                case '}':
                    if (!$garbage && $nest > 0) {
                        $nest--;
                    }
                    break;
                case '<':
                    $garbage = true;
                    break;
                case '>':
                    $garbage = false;
                    break;
                case '!':
                    $i++;
                    break;
            }
        }

        return array_sum($scores);
    }

    public function secondPart(): string
    {
        $stream = $this->input;
        $garbage = false;
        $characters = 0;
        echo PHP_EOL;
        for ($i = 0; $i < strlen($stream); $i++) {
            switch ($stream[$i]) {
                case '<':
                    if ($garbage) {
                        echo $stream[$i];
                        $characters++;
                    }
                    $garbage = true;
                    break;
                case '>':
                    $garbage = false;
                    break;
                case '!':
                    $i++;
                    break;
                default:
                    echo $stream[$i];
                    if ($garbage) {
                        $characters++;
                    }
                    break;
            }
        }

        return $characters;
    }
}
