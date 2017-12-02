<?php

declare(strict_types=1);

namespace Puzzles;

class Day2
{
    public static function solveTotalChecksum(string $puzzelInput) : int
    {
        $matrix = self::prepareMatrix($puzzelInput);
        $matrixChecksums = [];

        foreach ($matrix as $row) {
            $matrixChecksums[] = \max($row) - \min($row);
        }

        return \array_sum($matrixChecksums);
    }

    public static function solveEvenNumberChecksum(string $puzzelInput) : int
    {
        $matrix = self::prepareMatrix($puzzelInput);
        $matrixChecksums = [];

        foreach ($matrix as $row) {
            $rowTestedKeys = [];

            foreach ($row as $key => $value) {
                foreach ($row as $findKey => $findValue) {
                    if (!\in_array($findKey, $rowTestedKeys) && $key !== $findKey) {
                        if ($value > $findValue) {
                            $result = ($value / $findValue);
                        } else {
                            $result = ($findValue /$value);
                        }

                        if (\is_int($result)) {
                            $matrixChecksums[] = $result;
                            break;
                        }
                    }
                }
                $rowTestedKeys[] = $key;
            }
        }

        return \array_sum($matrixChecksums);
    }

    private static function prepareMatrix(string $matrixInput) : array
    {
        $matrix = [];
        $rows = \str_getcsv($matrixInput, "\n");

        foreach ($rows as $row) {
            $matrix[] = \str_getcsv($row, "\t");
        }

        return $matrix;
    }
}
