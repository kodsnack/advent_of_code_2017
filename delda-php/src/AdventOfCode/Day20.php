<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day20 extends AbstractAdventOfCode
{
    protected $class = 20;

    public function firstPart(): string
    {
        $particles = $this->parser($this->input);
        $solutions = $this->stayClosest($particles, 1000);
        uksort($solutions, function ($idxA, $idxB) use ($solutions) {
            $sumA = array_sum(array_map('abs', $solutions[$idxA]));
            $sumB = array_sum(array_map('abs', $solutions[$idxB]));
            if ($sumA == $sumB) {
                return 0;
            }
            return $sumA < $sumB ? -1 : 1;
        });
        return key($solutions);
    }

    public function secondPart(): string
    {
        $particles = $this->parser($this->input);
        $noCollitions = 0;
        $time = 0;
        do {
            $noCollitions = $this->removeCollisions($particles, $time++) ? 0 : $noCollitions + 1;
        } while ($noCollitions < 100);

        return sizeof($particles);
    }

    private function parser(string $input): array
    {
        $lines = explode(PHP_EOL, $input);

        return array_map(function ($line) {
            $coordinates = explode(', ', $line);
            foreach ($coordinates as $coordinate) {
                preg_match('/([pva])=<(-?\d+),(-?\d+),(-?\d+)>/', $coordinate, $matches);
                $particle[$matches[1]] = array_slice($matches, 2);
            }
            return (object)$particle;
        }, $lines);
    }

    private function stayClosest(array $particles, $time): array
    {
        return array_map(function ($particle) use ($time) {
            $solution = [];
            for ($i = 0; $i < 3; $i++) {
                $solution[$i] =
                    $particle->p[$i] +
                    $particle->v[$i] * $time +
                    $particle->a[$i] * $time * ($time + 1) / 2;
            }
            return $solution;
        }, $particles);
    }

    private function removeCollisions(array &$particles, int $time): bool
    {
        $collition = false;
        $newParticles = $this->stayClosest($particles, $time);
        $keysDuplicates = [];
        foreach ($newParticles as $key => $value) {
            $keys = array_keys($newParticles, $value);
            if (sizeof($keys) > 1) {
                foreach ($keys as $key) {
                    $keysDuplicates[] = $key;
                    unset($newParticles[$key]);
                    unset($particles[$key]);
                }
            }
        }

        return $collition;
    }
}
