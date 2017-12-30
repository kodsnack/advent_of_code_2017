<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day18 extends AbstractAdventOfCode
{
    protected $class = 18;

    public function firstPart(): string
    {
        return $this->playSound($this->input);
    }

    public function secondPart(): string
    {
        $idxA = 0;
        $registerA = [];
        $registerA['p'] = 0;
        $sndA = 0;
        $idxB = 0;
        $registerB = [];
        $registerB['p'] = 1;
        $sndB = 0;
        $code = [new \SplQueue(), new \SplQueue()];
        $input = explode("\n", $this->input);
        while (true) {
            $lockA = $this->assemblyCode($input, 0, $idxA, $registerA, $code, $sndA);
            $lockB = $this->assemblyCode($input, 1, $idxB, $registerB, $code, $sndB);
            if ($lockA && $lockB) {
                break;
            }
        }

        return $sndB;
    }

    private function playSound(string $commands): string
    {
        $registers = [];
        $registers['b'] = 0;
        $sound = 0;
        $commands = explode("\n", $commands);
        $idx = 0;
        while (true) {
            @list($cmd, $r1, $r2) = explode(' ', $commands[$idx]);
            switch ($cmd) {
                case 'snd':
                    $sound = $registers[$r1];
                    break;
                case 'set':
                    $term = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                    $registers[$r1] = $term;
                    break;
                case 'add':
                    $registers[$r1] += $r2;
                    break;
                case 'mul':
                    if (!isset($registers[$r1])) {
                        $registers[$r1] = 0;
                    }
                    $term2 = is_numeric($r2) ? $r2 : $registers[$r2];
                    $registers[$r1] *= $term2;
                    break;
                case 'mod':
                    $term = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                    $registers[$r1] %= $term;
                    break;
                case 'rcv':
                    if ($registers[$r1] != 0) {
                        return $sound;
                    }
                    break;
                case 'jgz':
                    if ($registers[$r1] > 0) {
                        $idx += $r2 - 1;
                    }
            }
            $idx++;
        }
    }

    private function assemblyCode(
        array $commands,
        int $programId,
        int &$idx,
        array &$registers,
        array &$code,
        int &$sndCounter
    ): int {
        @list($cmd, $r1, $r2) = explode(' ', $commands[$idx]);
        switch ($cmd) {
            case 'snd':
                $value = (isset($registers[$r1])) ? $registers[$r1] : $r1;
                $codeId = ($programId === 0) ? 1 : 0;
                $code[$codeId]->enqueue($value);
                $sndCounter++;
                break;
            case 'set':
                $term = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                $registers[$r1] = $term;
                break;
            case 'add':
                $term = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                $registers[$r1] += $term;
                break;
            case 'mul':
                if (!isset($registers[$r1])) {
                    $registers[$r1] = 0;
                }
                $term2 = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                $registers[$r1] *= $term2;
                break;
            case 'mod':
                $term = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                $registers[$r1] %= $term;
                break;
            case 'rcv':
                if ($code[$programId]->isEmpty()) {
                    return true;
                } else {
                    $registers[$r1] = $code[$programId]->dequeue();
                }
                break;
            case 'jgz':
                $term1 = is_numeric($r1) ? (int)$r1 : $registers[$r1];
                $term2 = is_numeric($r2) ? (int)$r2 : $registers[$r2];
                if ($term1 > 0) {
                    $idx += $term2 - 1;
                }
        }
        $idx++;
        return false;
    }
}
