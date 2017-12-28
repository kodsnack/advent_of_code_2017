<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;
use src\AdventOfCode\Day10;

class Day14 extends AbstractAdventOfCode
{
    protected $class = 14;

    public function firstPart(): string
    {
        $counter = 0;
        for ($i = 0; $i < 128; $i++) {
            $knotHashes = $this->getKnotHashes($this->input.'-'.$i);
            $bits = $this->binaryRappresentation($knotHashes);
            $counter += array_sum(str_split($bits));
        }

        return $counter;
    }

    public function secondPart(): string
    {
        $usedSquares = [];
        for ($i = 0; $i < 128; $i++) {
            $knotHashes = $this->getKnotHashes($this->input.'-'.$i);
            $bits = $this->binaryRappresentation($knotHashes);
            $usedSquares[] = str_split($bits);
        }

        return $this->findRegions($usedSquares);
    }

    public function getKnotHashes(string $input = null): string
    {
        $input = $input ?: $this->input;
        $aoc10 = new Day10($input);

        return $aoc10->secondPart();
    }

    public function binaryRappresentation(string $hex): string
    {
        $bits = '';
        for ($i = 0; $i < strlen($hex); $i++) {
            $char = $hex[$i];
            $bits .= str_pad(base_convert($char, 16, 2), 4, '0', STR_PAD_LEFT);
        }

        return $bits;
    }

    private function findRegions(array $usedSquares): int
    {
        $regions = 0;
        for ($x = 0; $x < 128; $x++) {
            for ($y = 0; $y < 128; $y++) {
                if ($usedSquares[$x][$y] === '1') {
                    $usedSquares = $this->markRegion($usedSquares, $x, $y);
                    $regions++;
                }
            }
        }

        return $regions;
    }

    private function markRegion(array $squares, int $x, int $y): array
    {
        $region = new \SplQueue();
        $region->enqueue([$x, $y]);
        while (!$region->isEmpty()) {
            list($x, $y) = $region->dequeue();
            $squares[$x][$y] = '#';
            foreach ($this->neighborhood($x, $y) as $coords) {
                if ($squares[$coords[0]][$coords[1]] === '1') {
                    $region->enqueue($coords);
                }
            }
        }

        return $squares;
    }

    private function neighborhood(int $x, int $y): array
    {
        $coords = [];
        if ($y > 0) {
            $coords[] = [$x, $y-1];
        }
        if ($x < 127) {
            $coords[] = [$x+1, $y];
        }
        if ($y < 127) {
            $coords[] = [$x, $y+1];
        }
        if ($x > 0) {
            $coords[] = [$x-1, $y];
        }

        return $coords;
    }
}
