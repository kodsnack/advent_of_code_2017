<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day2 extends AbstractAdventOfCode
{
    protected $class = 2;

    public function firstPart(): string
    {
        $spreadsheet = $this->input;
        $checksum = 0;
        foreach (explode(PHP_EOL, $spreadsheet) as $line) {
            $smallest = PHP_INT_MAX;
            $largest = 0;
            foreach (explode("\t", $line) as $number) {
                $smallest = min($smallest, $number);
                $largest = max($largest, $number);
            }
            $checksum += $largest - $smallest;
        }

        return $checksum;
    }

    public function secondPart(): string
    {
        $spreadsheet = $this->input;
        $checksum = 0;
        foreach (explode(PHP_EOL, $spreadsheet) as $line) {
            $line = explode("\t", $line);
            for ($i = 0; $i < sizeof($line) - 1; $i++) {
                for ($j = $i + 1; $j < sizeof($line); $j++) {
                    if ((max($line[$i], $line[$j]) % min($line[$i], $line[$j])) == 0) {
                        $checksum += max($line[$i], $line[$j]) / min($line[$i], $line[$j]);
                    }
                }
            }
        }

        return $checksum;
    }
}
