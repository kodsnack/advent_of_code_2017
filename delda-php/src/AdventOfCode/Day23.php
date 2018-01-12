<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day23 extends AbstractAdventOfCode
{
    protected $class = 23;

    public function firstPart(): string
    {
        $registers = [];
        for ($char = 'a'; $char <= 'h'; $char++) {
            $registers[$char] = 0;
        }

        return $this->instructions($this->input, $registers);
    }

    public function secondPart(): string
    {
        $b = 81 * 100 + 100000;
        $c = $b + 17000;
        $h = 0;
        while ($b <= $c) {
            if (!$this->isPrime($b)) {
                $h++;
            }
            $b += 17;
        }

        return $h;
    }

    private function isPrime(int $number): bool
    {
        for ($i = 2; $i < $number; $i++) {
            if ($number % $i == 0) {
                 return false;
            }
        }
        return true;
    }

    private function instructions(string $commands, array &$registers): int
    {
        $commands = explode("\n", $commands);
        $idx = 0;
        $mul = 0;
        while ($idx >= 0 && $idx < sizeof($commands)) {
            @list($cmd, $r1, $r2) = explode(' ', $commands[$idx]);
            switch ($cmd) {
                case 'set':
                    $registers[$r1] = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                    break;
                case 'sub':
                    $registers[$r1] -= is_numeric($r2) ? (int)$r2 : $registers[$r2];
                    break;
                case 'mul':
                    $mul++;
                    if (!isset($registers[$r1])) {
                        $registers[$r1] = 0;
                    }
                    $registers[$r1] *= is_numeric($r2) ? $r2 : $registers[$r2];
                    break;
                case 'jnz':
                    $value = is_numeric($r1) ? (int)$r1 : $registers[$r1];
                    if ($value != 0) {
                        $idx += is_numeric($r2) ? (int)$r2 : $registers[$r2];
                        $idx--;
                    }
            }
            $idx++;
        }

        return $mul;
    }
}
