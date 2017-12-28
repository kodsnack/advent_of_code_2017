<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day3 extends AbstractAdventOfCode
{
    protected $class = 3;

    public function firstPart(): string
    {
        $squareNumber = $this->input;

        if ($squareNumber == 1) {
            return 0;
        }

        $lenght = $this->distanceFromCenter($squareNumber);

        $squareDifference = $squareNumber - $this->numberOfSquares($lenght-1);
        $quarterLenght = 8 * ($lenght - 1) / 4;

        for ($quarter = 1; $quarter <= 4; $quarter++) {
            if ($squareDifference < $quarterLenght * $quarter) {
                break;
            }
        }

        $width = abs($squareDifference - (($quarterLenght * $quarter) - ($quarterLenght / 2)));

        return $width + $lenght - 1;
    }

    public function secondPart(): string
    {
        $squareNumber = (int)$this->input;
        $distanceFromCenter = $this->distanceFromCenter($squareNumber);

        $spiral = array_fill(0, 2 * $distanceFromCenter, array_fill(0, 2 * $distanceFromCenter, 0));
        $distanceFromCenter--;
        $x = $y = $distanceFromCenter;

        $spiral[$x][$y] = 1;
        for ($distance = 1; $distance <= $distanceFromCenter; $distance++) {
            $x = $y = $distanceFromCenter;
            for ($j = 0; $j < 2 * $distance; $j++) {
                $value = $this->neighborhoodCount($spiral, $x+$distance, $y-$j+$distance-1);
                if ($value > $squareNumber) {
                    return $value;
                } else {
                    $spiral[$x+$distance][$y-$j+$distance-1] = $value;
                }
            }
            $j--;
            for ($i = 0; $i < 2 * $distance; $i++) {
                $value = $this->neighborhoodCount($spiral, $x-$i+$distance-1, $y-$j+$distance-1);
                if ($value > $squareNumber) {
                    return $value;
                } else {
                    $spiral[$x-$i+$distance-1][$y-$j+$distance-1] = $value;
                }
            }
            $i--;
            for ($j = 0; $j < 2 * $distance; $j++) {
                $value = $this->neighborhoodCount($spiral, $x-$i+$distance-1, $y+$j-$distance+1);
                if ($value > $squareNumber) {
                    return $value;
                } else {
                    $spiral[$x-$i+$distance-1][$y+$j-$distance+1] = $value;
                }
            }
            $j--;
            for ($i = 0; $i < 2 * $distance; $i++) {
                $value = $this->neighborhoodCount($spiral, $x+$i-$distance+1, $y+$j-$distance+1);
                if ($value > $squareNumber) {
                    return $value;
                } else {
                    $spiral[$x+$i-$distance+1][$y+$j-$distance+1] = $value;
                }
            }
        }

        return 0;
    }

    private function numberOfSquares(int $length): int
    {
        return pow(2 * $length - 1, 2);
    }

    private function distanceFromCenter(int $squareNumber): int
    {
        $numberOfSquares = $lenght = 1;
        while ($squareNumber > $numberOfSquares) {
            $numberOfSquares = $this->numberOfSquares($lenght++);
        }

        return --$lenght;
    }

    private function neighborhoodOrdered(int $x, int $y): array
    {
        $nodes = [];
        $nodes[] = [$x  ,$y+1];
        $nodes[] = [$x-1,$y+1];
        $nodes[] = [$x-1,$y  ];
        $nodes[] = [$x-1,$y-1];
        $nodes[] = [$x  ,$y-1];
        $nodes[] = [$x+1,$y-1];
        $nodes[] = [$x+1,$y  ];
        $nodes[] = [$x+1,$y+1];

        return $nodes;
    }

    private function neighborhoodCount(array $spiral, int $x, int $y): int
    {
        return array_reduce(
            $this->neighborhoodOrdered($x, $y),
            function ($carry, $coordinates) use ($spiral) {
                $carry += isset($spiral[$coordinates[0]][$coordinates[1]])
                    ? $spiral[$coordinates[0]][$coordinates[1]]
                    : 0;
                return $carry;
            },
            0
        );
    }
}
