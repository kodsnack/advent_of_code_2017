<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day13 extends AbstractAdventOfCode
{
    protected $class = 13;

    public function firstPart(): string
    {
        $firewall = $this->parser();

        return $this->scannerMoves($firewall, 0, false);
    }

    public function secondPart(): string
    {
        $time = 0;
        $firewall = $this->parser();
        while($this->scannerMoves($firewall, $time, true)) {
            $time++;
        }

        return $time;
    }

    private function parser(): array
    {
        return array_reduce(
            explode("\n", $this->input),
            function ($carry, $line) {
                list($idx, $depth) = explode(': ', $line);
                $carry[$idx] = $depth;
                return $carry;
            },
            []
        );
    }

    private function scannerMoves(array $firewall, int $time, bool $breakOnCaught): int
    {
        $severity = 0;
        end($firewall);
        $firewallLenght = key($firewall);
        for ($level = 0; $level <= $firewallLenght; $level++){
            if (!isset($firewall[$level])) {
                $time++;
                continue;
            }
            if ($time % (2 * ($firewall[$level] - 1)) == 0) {
                $severity += $level * $firewall[$level];
                if ($breakOnCaught) {
                    $severity++;
                }
            }
            $time++;
        }

        return $severity;
    }
}
